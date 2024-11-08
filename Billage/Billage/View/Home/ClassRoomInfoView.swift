//
//  ClassRoomInfoView.swift
//  Billage
//
//  Created by 변상우 on 11/5/24.
//

import SwiftUI

struct ClassRoomInfoView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var reservationStore: ReservationStore
    
    @Binding var selectedBuilding: String
    @Binding var selectedDateString: String
    @Binding var selectedClassRoomId: Int
    @Binding var selectedHeadCount: Int
    
    var classRoomDetailInfo: ClassRoomInfo = ClassRoomInfo(classroomId: 0, classroomName: "", classroomNumber: "", capacity: 0, description: "", classroomImages: [], reservationTimes: [])
    
    private var nextButtonStatus: Bool {
        return true
    }
    
    var body: some View {
        VStack {
            BillageNavigationBar(title: "강의실 정보") {
                dismiss()
            }
            
            HStack {
                Text("\(reservationStore.classRoomDetailInfo.classroomNumber)호")
                    .font(.head)
                    .foregroundStyle(Color.billGray1)
                
                Text("|  \(reservationStore.classRoomDetailInfo.classroomName)  |  기준인원 \(reservationStore.classRoomDetailInfo.capacity)명")
                    .font(.body)
                    .foregroundStyle(Color.billGray1)
                
                Spacer()
            }
            .padding(.leading, 25)
            .padding(.vertical, 20)
            
            Rectangle()
                .foregroundStyle(Color.billGray5)
                .frame(height: 2)
            
            VStack(alignment: .leading) {
                Text("강의실 내부")
                    .font(.bodysemibold)
                    .foregroundStyle(Color.billGray1)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(0..<5, id: \ .self) { _ in
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 180)
                        }
                    }
                    .padding(.top, 8)
                }
            }
            .padding(.leading, 20)
            .padding(.top, 10)
            
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("사용 가능 시간")
                        .font(.bodysemibold)
                        .padding(.vertical, 17)
                        .padding(.leading, 12)
                    
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
                                .fill(isInAnyRange(hour: hour, reservationTimes: reservationStore.classRoomDetailInfo.reservationTimes) ? Color.gray : Color.white)
                                .frame(height: 26)
                                .overlay(
                                    Rectangle()
                                        .stroke(Color.billGray2, lineWidth: 0.5)
                                )
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 19)
                    
                    Rectangle()
                        .foregroundStyle(Color.billGray5)
                        .frame(height: 2) // 두께를 2로 설정
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("기자재목록")
                                .font(.bodysemibold)
                                .foregroundStyle(Color.billGray1)
                                .padding(.leading, 12)
                            
                            Text(reservationStore.classRoomDetailInfo.description)
                                .font(.body)
                                .foregroundStyle(Color.billGray1)
                                .padding(.leading, 39)
                        }
                    }
                    .padding(.vertical, 15)
                }
                .background(Color.billGray4)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.billGray5, lineWidth: 2)
                )
            }
            .padding(.top, 8)
            .padding(.horizontal, 20)
            
            Spacer()
            
            NavigationLink {
                ClassRoomApplyView(selectedBuilding: $selectedBuilding, selectedDateString: $selectedDateString, selectedClassRoomId: $selectedClassRoomId, selectedHeadCount: $selectedHeadCount)
            } label: {
                Text("신청하기")
                    .billageButtonModifier(width: .screenWidth * 0.9, height: 50, isEnabled: nextButtonStatus)
            }
            .padding(.vertical, 10)
            .disabled(!nextButtonStatus)
            .foregroundStyle(nextButtonStatus ? Color.billColor1 : Color.billGray3)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            print("selectedClassRoomId: \(selectedClassRoomId)")
            print("selectedDateString: \(selectedDateString)")
            
            reservationStore.getUnivClassRoomInfo(classroomId: selectedClassRoomId, date: selectedDateString) { result in
                if result {
                    
                }
            }
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
