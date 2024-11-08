//
//  ClassRoomApplyView.swift
//  Billage
//
//  Created by 변상우 on 11/5/24.
//

import SwiftUI

struct ClassRoomApplyView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var overlayManager: OverlayManager
    @EnvironmentObject var navigationPathManager: NavigationPathManager
    @EnvironmentObject var reservationStore: ReservationStore
    
    @Binding var selectedBuilding: String
    @Binding var selectedDateString: String
    @Binding var selectedClassRoomId: Int
    @Binding var selectedHeadCount: Int
    
    @State private var isStartTimePickerPresented: Bool = false
    @State private var isEndTimePickerPresented: Bool = false
    @State private var isShowingReasonBottomSheet = false
    @State private var startTime: Int = 0
    @State private var endTime: Int = 0
    @State private var phoneNumber: String = ""
    @State private var selectedReason = ""
    @State private var memo: String = ""
    
    private var nextButtonStatus: Bool {
        return true
    }
    
    var body: some View {
        ZStack {
            VStack {
                BillageNavigationBar(title: "건물명") {
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
                
                ScrollView {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("사용 희망 시간")
                                .font(.bodysemibold)
                                .padding(.top, 12)
                                .padding(.leading, 12)
                                .padding(.bottom, 19)
                            
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
                                        .fill(isInSelectedRange(hour: hour) ? Color.billColor1 : isInAnyRange(hour: hour, reservationTimes: reservationStore.classRoomDetailInfo.reservationTimes) ? Color.gray :
                                            Color.white
                                        )
                                        .frame(height: 26)
                                        .overlay(
                                            Rectangle()
                                                .stroke(Color.billGray2, lineWidth: 0.5)
                                        )
                                }
                            }
                            .padding(.horizontal, 15)
                            .padding(.bottom, 10)
                            
                            Rectangle()
                                .foregroundStyle(Color.billGray5)
                                .frame(height: 2) // 두께를 2로 설정
                            
                            HStack {
                                Spacer()
                                VStack {
                                    Button {
                                        isStartTimePickerPresented = true
                                    } label: {
                                        HStack(spacing: 0) {
                                            Text(String(format: "%02d", startTime))
                                                .font(.option)
                                                .foregroundStyle(Color.wh)
                                                .frame(width: 68)
                                            
                                            Rectangle()
                                                .foregroundStyle(Color.billGray4)
                                                .frame(width: 1)
                                            
                                            Text("00")
                                                .font(.option)
                                                .foregroundStyle(Color.wh)
                                                .frame(width: 68)
                                        }
                                        .background(Color.billColor1)
                                        .frame(height: 40)
                                        .cornerRadius(6)
                                    }
                                    .sheet(isPresented: $isStartTimePickerPresented) {
                                        VStack {
                                            Text("Select Start Time")
                                                .font(.headline)
                                                .padding()
                                            
                                            Picker("Hour", selection: $startTime) {
                                                ForEach(9..<25, id: \.self) { hour in
                                                    Text("\(hour) 시")
                                                }
                                            }
                                            .labelsHidden()
                                            .pickerStyle(WheelPickerStyle())
                                            .frame(height: 200)
                                            .padding()
                                            
                                            Button("확인") {
                                                isStartTimePickerPresented = false
                                            }
                                            .padding()
                                        }
                                    }
                                }
                                
                                Text("~")
                                    .font(.body)
                                    .padding(.horizontal)
                                
                                VStack {
                                    Button {
                                        isEndTimePickerPresented = true
                                    } label: {
                                        HStack(spacing: 0) {
                                            Text(String(format: "%02d", endTime))
                                                .font(.option)
                                                .foregroundStyle(Color.wh)
                                                .frame(width: 68)
                                            
                                            Rectangle()
                                                .foregroundStyle(Color.billGray4)
                                                .frame(width: 1)
                                            
                                            Text("00")
                                                .font(.option)
                                                .foregroundStyle(Color.wh)
                                                .frame(width: 68)
                                        }
                                        .background(Color.billColor1)
                                        .frame(height: 40)
                                        .cornerRadius(6)
                                    }
                                    .sheet(isPresented: $isEndTimePickerPresented) {
                                        VStack {
                                            Text("Select End Time")
                                                .font(.headline)
                                                .padding()
                                            
                                            Picker("Hour", selection: $endTime) {
                                                ForEach(startTime + 1..<25, id: \ .self) { hour in
                                                    Text("\(hour) 시")
                                                }
                                            }
                                            .labelsHidden()
                                            .pickerStyle(WheelPickerStyle())
                                            .frame(height: 200)
                                            .padding()
                                            
                                            Button("확인") {
                                                isEndTimePickerPresented = false
                                            }
                                            .padding()
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding(.vertical, 14)
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
                    .padding(.bottom, 12)
                    
                    VStack {
                        VStack(alignment: .leading) {
                            Text("전화번호")
                                .font(.bodysemibold)
                                .foregroundStyle(Color.billGray1)
                                .padding(.top, 12)
                                .padding(.leading, 12)
                            
                            TextField("전화번호 입력...", text: $phoneNumber)
                                .billageTextFieldModifier(width: .infinity, height: 52)
                                .keyboardType(.numberPad) // 숫자 키패드
                                .font(.body)
                                .foregroundStyle(Color.billGray1)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8) // 둥근 모서리 추가
                                        .stroke(Color.billGray3, lineWidth: 1.5) // 테두리 색과 두께 설정
                                )
                                .padding(.bottom, 16)
                                .padding(.leading, 12)
                                .padding(.trailing, 7)
                        }
                        .background(Color.billGray4)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.billGray5, lineWidth: 2)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)
                    
                    VStack {
                        VStack(alignment: .leading) {
                            Text("사유")
                                .font(.bodysemibold)
                                .foregroundStyle(Color.billGray1)
                                .padding(.top, 12)
                                .padding(.leading, 12)
                            
                            Button {
                                overlayManager.showSheet(
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("사유를 선택해주세요")
                                                .font(.bodybold)
                                                .padding(.top, 35)
                                                .padding(.bottom, 16)
                                            
                                            VStack(alignment: .leading, spacing: 16) {
                                                Button {
                                                    selectedReason = "학과 행사"
                                                    overlayManager.hideSheet()
                                                } label: {
                                                    Text("학과 행사")
                                                        .font(.body)
                                                        .foregroundStyle(Color.billGray1)
                                                }
                                                
                                                Button {
                                                    selectedReason = "단과대 행사"
                                                    overlayManager.hideSheet()
                                                } label: {
                                                    Text("단과대 행사")
                                                        .font(.body)
                                                        .foregroundStyle(Color.billGray1)
                                                }
                                                
                                                Button {
                                                    selectedReason = "동아리 행사"
                                                    overlayManager.hideSheet()
                                                } label: {
                                                    Text("동아리 행사")
                                                        .font(.body)
                                                        .foregroundStyle(Color.billGray1)
                                                }
                                                
                                                Button {
                                                    selectedReason = "기타: 메모에 입력 요망"
                                                    overlayManager.hideSheet()
                                                } label: {
                                                    Text("기타: 메모에 입력 요망")
                                                        .font(.body)
                                                        .foregroundStyle(Color.billGray1)
                                                }
                                            }
                                            .padding(.bottom, 35)
                                        }
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.leading, 21)
                                )
                            } label: {
                                Text(selectedReason.isEmpty ? "선택하세요..." : selectedReason)
                                    .frame(maxWidth: .infinity, maxHeight: 52, alignment: .leading)
                                    .font(.body)
                                    .foregroundStyle(selectedReason.isEmpty ? Color.billGray3 : Color.billGray1)
                                    .padding(.leading, 15)
                                    .padding(.vertical, 14)
                                    .background(Color.billWh)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8) // 둥근 모서리 추가
                                            .stroke(Color.billGray3, lineWidth: 1.5) // 테두리 색과 두께 설정
                                    )
                            }
                            .contentShape(Rectangle())
                            .padding(.leading, 12)
                            .padding(.trailing, 7)
                            .padding(.bottom, 24)
                        }
                        .background(Color.billGray4)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.billGray5, lineWidth: 2)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)
                    
                    VStack {
                        VStack(alignment: .leading) {
                            Text("메모")
                                .font(.bodysemibold)
                                .foregroundStyle(Color.billGray1)
                                .padding(.top, 12)
                                .padding(.leading, 12)
                            
                            TextField("자유롭게 입력하세요...", text: $memo)
                                .billageTextFieldModifier(width: .infinity, height: 110)
                                .font(.body)
                                .foregroundStyle(Color.billGray1)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8) // 둥근 모서리 추가
                                        .stroke(Color.billGray3, lineWidth: 1.5) // 테두리 색과 두께 설정
                                )
                                .padding(.bottom, 16)
                                .padding(.leading, 12)
                                .padding(.trailing, 7)
                        }
                        .background(Color.billGray4)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.billGray5, lineWidth: 2)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)
                    
                    Button {
                        overlayManager.showSheet(
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("대여를 신청하시겠습니까?")
                                        .font(.bodybold)
                                        .padding(.top, 35)
                                        .padding(.bottom, 16)
                                    
                                    VStack(alignment: .leading) {
                                        Text("일시   \(selectedDateString), \(startTime):00 ~ \(endTime):00")
                                            .font(.body)
                                            .foregroundStyle(Color.billGray1)
                                        
                                        Text("장소   \(selectedBuilding) \(reservationStore.classRoomDetailInfo.classroomNumber)호")
                                            .font(.body)
                                            .foregroundStyle(Color.billGray1)
                                    }
                                    .padding(.bottom, 35)
                                    
                                    VStack(spacing: 8) {
                                        Button {
                                            overlayManager.hideSheet()
                                            navigationPathManager.resetToRoot()
                                            
                                            print("classroomId: \(selectedClassRoomId)")
                                            print("phoneNumber: \(formatPhoneNumber(phoneNumber))")
                                            print("applyDate: \(selectedDateString)")
                                            print("startTime: \(startTime):00")
                                            print("endTime: \(endTime):00")
                                            print("headcount: \(selectedHeadCount)")
                                            print("purpose: \(selectedReason)")
                                            print("contents: \(memo)")
                                            
                                            reservationStore.postReservations(
                                                classroomId: selectedClassRoomId,
                                                phoneNumber: formatPhoneNumber(phoneNumber),
                                                applyDate: selectedDateString,
                                                startTime: "\(startTime):00",
                                                endTime: "\(endTime):00",
                                                headcount: selectedHeadCount,
                                                purpose: selectedReason,
                                                contents: memo
                                            )
                                        } label: {
                                            Text("신청")
                                                .billageButtonModifier(width: .infinity, height: 44, isEnabled: nextButtonStatus)
                                        }
                                        
                                        Button {
                                            overlayManager.hideSheet()
                                        } label: {
                                            Text("취소")
                                                .billageCancelButtonModifier(width: .infinity, height: 44)
                                        }
                                    }
                                    .padding(.bottom, 20)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 21)
                        )
                    } label: {
                        Text("신청하기")
                            .billageButtonModifier(width: .screenWidth * 0.9, height: 50, isEnabled: nextButtonStatus)
                    }
                    .padding(.vertical, 10)
                    .disabled(!nextButtonStatus)
                    .foregroundStyle(nextButtonStatus ? Color.billColor1 : Color.billGray3)
                }
            }
            .navigationBarBackButtonHidden(true)
            .onTapGesture {
                self.hideKeyboard()
            }
        }
        .onAppear {
            OverlayWindow.shared.hide() // 앱 시작 시 숨김 상태로 유지
        }
    }
    
    func isInSelectedRange(hour: Int) -> Bool {
        return hour >= startTime && hour < endTime
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
    
    func formatPhoneNumber(_ phoneNumber: String) -> String {
        let cleanPhoneNumber = phoneNumber.filter { $0.isNumber }
        
        guard cleanPhoneNumber.count == 11 else {
            return phoneNumber // 유효하지 않은 길이면 원본 반환
        }
        
        let startIndex = cleanPhoneNumber.index(cleanPhoneNumber.startIndex, offsetBy: 3)
        let middleIndex = cleanPhoneNumber.index(cleanPhoneNumber.startIndex, offsetBy: 7)
        
        let formattedNumber = "\(cleanPhoneNumber[..<startIndex])-\(cleanPhoneNumber[startIndex..<middleIndex])-\(cleanPhoneNumber[middleIndex...])"
        
        return formattedNumber
    }
}
