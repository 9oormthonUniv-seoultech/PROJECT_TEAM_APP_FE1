//
//  SelectClassRoomView.swift
//  Billage
//
//  Created by 변상우 on 11/5/24.
//

import SwiftUI

struct SelectClassRoomView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var reservationStore: ReservationStore
    
    @Binding var selectedDateString: String
    @Binding var selectedHeadCount: Int
    @Binding var selectedBuilding: String
    @Binding var selectedBuildingId: Int
    @Binding var selectedBuildingNumber: Int
    @Binding var selectedBuildingFloors: [Int]
    
    @State private var selectedFloor: Int = 1
    @State private var selectedRoomIndex: Int? = nil
    @State private var selectedClassRoomId: Int = 0
    @State private var selectedButtonIndex: Int? = nil
    
    private var nextButtonStatus: Bool {
        return true
    }
    
    var body: some View {
        VStack {
            BillageNavigationBar(title: "\(selectedBuilding)(\(selectedBuildingNumber))") {
                dismiss()
            }
            
            VStack {
                HStack {
                    Text(convertDateFormat(from: selectedDateString))
                        .font(.head2)
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                .frame(height: 44)
                
                Divider()
                    .foregroundStyle(.billageGray5)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(selectedBuildingFloors, id: \.self) { floor in
                            Button {
                                selectedFloor = floor
                            } label: {
                                Text("\(floor)층")
                                    .font(.par)
                                    .foregroundColor(selectedFloor == floor ? Color.billGray1 : Color.billGray3)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 12)
                                    .background(selectedFloor == floor ? Color.billGray5 : .clear)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                
                Divider()
                    .foregroundStyle(.billageGray5)
            }
            .background(Color.whg)
            
            HStack(spacing: 0) {
                Text("사용 가능 시간")
                    .font(.sub)
                    .foregroundStyle(Color.billGray1)
                    .padding(.trailing, 12)
                
                Rectangle()
                    .fill(Color.wh)
                    .frame(width: 12, height: 12)
                    .overlay(
                        Rectangle()
                            .stroke(Color.billGray4, lineWidth: 1)
                    )
                
                Text("예약 불가 시간")
                    .font(.sub)
                    .foregroundStyle(Color.billGray1)
                    .padding(.leading, 27)
                
                Rectangle()
                    .fill(Color.billGray3)
                    .frame(width: 12, height: 12)
                    .padding(.leading, 12)
                
                Spacer()
            }
            .padding(.vertical, 12)
            .padding(.leading, 20)

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(Array(reservationStore.classRoomList.enumerated()), id: \.element) { index, data in
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(data.classroomNumber)호")
                                    .font(.head)
                                    .foregroundStyle(Color.billGray1)
                                
                                Spacer()
                                
                                Text("\(data.classroomName)  |  기준인원 \(data.capacity)명")
                                    .font(.body)
                                    .foregroundStyle(Color.billGray1)
                            }
                            .padding(.vertical, 11)
                            
                            HStack {
                                let times = ["9", "12", "15", "18", "21", "24"]
                                ForEach(times, id: \.self) { time in
                                    Text(time)
                                        .font(.times)
                                        .foregroundStyle(Color.billGray3)
                                    
                                    if time != times.last {
                                        Spacer()
                                    }
                                }
                            }
                            .padding(.horizontal, 15)
                            
                            HStack(spacing: 0) {
                                ForEach(9..<24, id: \ .self) { hour in
                                    Rectangle()
                                        .fill(isInAnyRange(hour: hour, reservationTimes: data.reservationTimes) ? Color.gray : Color.white)
                                        .frame(height: 26)
                                        .overlay(
                                            Rectangle()
                                                .stroke(Color.billGray2, lineWidth: 0.5)
                                        )
                                }
                            }
                            .padding(.bottom, 19)
                        }
                        .padding(.horizontal, 15)
                        .background(selectedRoomIndex == index ? Color.billColor2 : Color.billGray4)
                        .cornerRadius(8)
                        .onTapGesture {
                            selectedRoomIndex = index
                            selectedClassRoomId = data.classroomId
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .scrollIndicators(.hidden)
            
            Spacer()
            
            NavigationLink {
                ClassRoomInfoView(selectedBuilding: $selectedBuilding, selectedDateString: $selectedDateString, selectedClassRoomId: $selectedClassRoomId, selectedHeadCount: $selectedHeadCount)
            } label: {
                Text("다음으로")
                    .billageButtonModifier(width: .screenWidth * 0.9, height: 50, isEnabled: nextButtonStatus)
            }
            .padding(.vertical, 10)
            .disabled(!nextButtonStatus)
            .foregroundStyle(nextButtonStatus ? Color.billColor1 : Color.billGray3)
        }
        .onAppear {
            reservationStore.getUnivClassRoom(
                buildingId: selectedBuildingId,
                floor: selectedBuildingFloors[0],
                date: selectedDateString,
                headcount: selectedHeadCount
            ) { result in
                if result {
                    
                }
            }
        }
        .background(Color.wh)
        .navigationBarBackButtonHidden(true)
    }
    
    func convertDateFormat(from originalDateString: String) -> String {
        // 입력 형식 설정 (yyyy-MM-dd)
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        // 출력 형식 설정 (yyyy년 M월 d일)
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "ko_KR") // 한국어 설정
        outputFormatter.dateFormat = "yyyy년 M월 d일"

        // 문자열 -> 날짜 객체 -> 변환된 문자열
        if let date = inputFormatter.date(from: originalDateString) {
            return outputFormatter.string(from: date)
        } else {
            return "유효하지 않은 날짜 형식" // 기본값 반환
        }
    }
    
    func isInAnyRange(hour: Int, reservationTimes: [ReservationTime]) -> Bool {
        for time in reservationTimes {
            if isInRange(hour: hour, startTime: time.startTime, endTime: time.endTime) {
                return true
            }
        }
        return false
    }
    
    // 시간 범위를 판단하는 함수
    func isInRange(hour: Int, startTime: String, endTime: String) -> Bool {
        // "HH:mm" 형식의 문자열을 시간 값(Int)으로 변환
        let startHour = Int(startTime.prefix(2)) ?? 0
        let endHour = Int(endTime.prefix(2)) ?? 0

        // 현재 슬롯 시간이 범위에 포함되는지 여부 반환
        return hour >= startHour && hour < endHour
    }
}
