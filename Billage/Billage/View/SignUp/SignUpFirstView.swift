//
//  SignUpFirstView.swift
//  Billage
//
//  Created by 변상우 on 9/23/24.
//

import SwiftUI

enum StudentNumberStatus {
    case empty
    case valid
    case invalid
}

struct SignUpFirstView: View {
    
    @EnvironmentObject var signUpUserStore: SignUpUserStore
    
    @State private var name: String = ""
    @State private var studentNumber: String = ""
    @State private var phoneNumber: String = ""
    
    @State private var studentNumberStatus: StudentNumberStatus = .empty
    
    private var nextButtonStatus: Bool {
        return name != "" && studentNumber != "" && phoneNumber != "" ? true : false
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                TextField("이름", text: $name)
                    .billageTextFieldModifier(width: .screenWidth * 0.9, height: 52)
                    .font(.body)
                    .foregroundStyle(Color.billGray1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8) // 둥근 모서리 추가
                            .stroke(Color.billGray3, lineWidth: 1.5) // 테두리 색과 두께 설정
                    )
                
                ZStack {
                    VStack(alignment: .leading, spacing: 4) {
                        TextField("학번", text: $studentNumber)
                            .billageTextFieldModifier(width: .screenWidth * 0.9, height: 52)
                            .font(.body)
                            .foregroundStyle(Color.billGray1)
                            .keyboardType(.numberPad)
                            .onChange(of: studentNumber) {
                                studentNumberStatus(for: studentNumber) { status in
                                    studentNumberStatus = status
                                }
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8) // 둥근 모서리 추가
                                    .stroke(borderColor(for: studentNumberStatus), lineWidth: 1.5) // 테두리 색과 두께 설정
                            )
                    }
                    
                    HStack(alignment: .center) {
                        Spacer()
                        
                        if (studentNumberStatus == .empty) {
                            Image("check_box")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .padding(.trailing, 43)
                        } else {
                            Image(studentNumberStatus == .valid ? "check_box_fill" : "x_button")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20)
                                .padding(.trailing, 43)
                        }
                    }
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 4)
            
            HStack {
                if (studentNumberStatus == .empty) {
                    Text("학번당 1회만 가입할 수 있습니다")
                        .font(.par)
                        .foregroundStyle(Color.billGray3)
                } else {
                    Text(studentNumberStatus == .valid ? "사용 가능한 학번입니다" : "이미 가입된 학번입니다")
                        .font(.par)
                        .foregroundStyle(studentNumberStatus == .valid ? Color.billColor1 : Color.billError)
                }
                
                Spacer()
            }
            .padding(.leading, 36)
            .padding(.bottom, 31)
            
            TextField("전화번호 입력...", text: $phoneNumber)
                .billageTextFieldModifier(width: .screenWidth * 0.9, height: 52)
                .font(.body)
                .foregroundStyle(Color.billGray1)
                .keyboardType(.numberPad)
                .overlay(
                    RoundedRectangle(cornerRadius: 8) // 둥근 모서리 추가
                        .stroke(Color.billGray3, lineWidth: 1.5) // 테두리 색과 두께 설정
                )
            
            Spacer()
            
            NavigationLink {
                SignUpSecondView()
            } label: {
                Text("다음으로")
                    .billageButtonModifier(width: .screenWidth * 0.9, height: 50, isEnabled: nextButtonStatus)
            }
            .padding(.bottom, 40)
            .disabled(!nextButtonStatus)
            .foregroundStyle(nextButtonStatus ? Color.billColor1 : Color.billGray3)
            .onDisappear {
                signUpUserStore.signUpUser.name = name
                signUpUserStore.signUpUser.studentNumber = studentNumber
                signUpUserStore.signUpUser.phoneNumber = formatPhoneNumber(phoneNumber)
            }
        }
        .navigationBarTitle("필수 정보 입력")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .backButtonArrow()
    }
    
    // 상태 반환 함수
    private func studentNumberStatus(for studentNumber: String, completion: @escaping (StudentNumberStatus) -> Void) {
        if studentNumber.isEmpty {
            completion(.empty)
        } else if studentNumber.count > 7 {
            signUpUserStore.getDoubleCheckStudentNumber(studentNumber: studentNumber) { result in
                if result {
                    completion(.valid)
                } else {
                    completion(.invalid)
                }
            }
        } else {
            completion(.empty)
        }
    }
    
    private func borderColor(for status: StudentNumberStatus) -> Color {
        switch status {
        case .empty:
            return Color.billGray3
        case .valid:
            return Color.billColor1
        case .invalid:
            return Color.billError
        }
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
