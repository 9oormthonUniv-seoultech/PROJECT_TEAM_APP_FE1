//
//  SignUpFourthView.swift
//  Billage
//
//  Created by 변상우 on 10/2/24.
//

import SwiftUI

struct SignUpFourthView: View {
    
    @EnvironmentObject var signUpUserStore: SignUpUserStore
    
    @State private var email = ""
    @State private var code: [String] = Array(repeating: "", count: 4)
    @State private var isCodeVerification: Bool = false
    
    @FocusState private var focusedField: Int?
    
    var isEmailValid: Bool {
        // 간단한 이메일 형식 확인 정규식
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    private var nextButtonStatus: Bool {
        return isEmailValid && isCodeVerification
    }
    
    var body: some View {
        VStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("학교 웹메일")
                        .font(.bodysemibold)
                        .foregroundStyle(Color.billGray1)
                        .padding(.top, 30)
                    
                    HStack(spacing: 9) {
                        TextField("example@" + "seoultech.ac.kr...", text: $email)
                            .billageTextFieldModifier(width: .infinity, height: 52)
                            .font(.body)
                            .foregroundStyle(Color.billGray1)
                            .onChange(of: email) {
                                print("isEmailValid: \(isEmailValid)")
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8) // 둥근 모서리 추가
                                    .stroke(Color.billGray3, lineWidth: 1.5) // 테두리 색과 두께 설정
                            )
                        
                        Button {
                            signUpUserStore.postEmailCertification(email: email) { result in
                                if result {
                                    print("이메일 보내기 성공")
                                } else {
                                    print("이메일 보내기 실패")
                                }
                            }
                        } label: {
                            Text("인증하기")
                                .font(.body)
                                .foregroundStyle(isEmailValid ? Color.billWh : Color.billColor1)
                                .frame(width: 90, height: 52)
                                .background(isEmailValid ? Color.billColor1 : Color.billWh)
                                .clipShape(RoundedRectangle(cornerRadius: 8)) // 버튼 전체에 둥근 모서리 적용
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8) // 둥근 모서리 추가
                                        .stroke(Color.billColor1, lineWidth: 1.5) // 테두리 색과 두께 설정
                                )
                        }
                        .disabled(!isEmailValid) // 이메일이 유효하지 않으면 버튼 비활성화
                    }
                    
                    Text("학적 인증을 위한 웹메일 인증이 필요합니다\n수신함을 확인해주세요!")
                        .font(.par)
                        .foregroundStyle(Color.billGray3)
                        .padding(.leading, 16)
                }
                
                VStack(alignment: .leading) {
                    Text("인증코드")
                        .font(.bodysemibold)
                        .foregroundStyle(Color.billGray1)
                    
                    HStack(spacing: 10) {
                        ForEach(0..<4, id: \.self) { index in
                            TextField("", text: $code[index])
                                .keyboardType(.numberPad) // 숫자 키패드
                                .multilineTextAlignment(.center) // 텍스트 가운데 정렬
                                .frame(width: 52, height: 52) // 텍스트 필드 크기 설정
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.billGray3, lineWidth: 1.5)
                                )
                                .focused($focusedField, equals: index) // 각 텍스트 필드를 포커스 상태로 연결
                                .onChange(of: code[index]) {
                                    // 입력된 값이 1자리 이상일 때 잘라내기
                                    if code[index].count > 1 {
                                        code[index] = String(code[index].prefix(1))
                                    }
                                    
                                    // 값이 비어있을 때 백스페이스를 감지하고 이전 필드로 이동
                                    if code[index].isEmpty && index > 0 {
                                        if index == 0 {
                                            focusedField = index
                                        } else {
                                            focusedField = index - 1
                                        }
                                    }

                                    // 현재 필드에서 한 자리 입력 후 다음 필드로 자동 이동
                                    if !code[index].isEmpty {
                                        focusedField = index < 5 ? index + 1 : nil // 마지막 필드가 아니면 다음 필드로 이동
                                    }
                                    
                                    isCodeVerification = false
                                    print("code: \(code)")
                                }
                                .onSubmit {
                                    // 엔터를 누르면 다음 필드로 이동
                                    focusedField = index < 5 ? index + 1 : nil
                                    print("code: \(code)")
                                }
                        }
                        
                        Button {
                            signUpUserStore.postEmailCodeVerification(email: email, codeNumber: Int(code.joined()) ?? 0000) { result in
                                if result {
                                    isCodeVerification = true
                                } else {
                                    isCodeVerification = false
                                }
                            }
                        } label: {
                            Text("인증하기")
                                .font(.body)
                                .foregroundStyle(code.joined().count == 4 ? Color.billWh : Color.billGray3)
                                .frame(width: 90, height: 52)
                                .background(code.joined().count == 4 ? Color.billColor1 : Color.billGray5)
                                .clipShape(RoundedRectangle(cornerRadius: 8)) // 버튼 전체에 둥근 모서리 적용
                        }
                        .disabled(code.joined().count != 4) // 코드가 4개가 아닐 때 버튼 비활성화
                    }
                    
                    Text("인증 코드를 입력해주세요")
                        .font(.par)
                        .foregroundStyle(Color.billGray3)
                        .padding(.leading, 16)
                }
                .padding(.top, 86)
            }
            .padding(.horizontal, 20)
            Spacer()
            
            NavigationLink {
                SignUpFifthView()
            } label: {
                Text("다음으로")
                    .billageButtonModifier(width: .screenWidth * 0.9, height: 50, isEnabled: nextButtonStatus)
            }
            .padding(.bottom, 40)
            .disabled(!nextButtonStatus)
            .foregroundStyle(nextButtonStatus ? Color.billColor1 : Color.billGray3)
            .onDisappear {
                signUpUserStore.signUpUser.studentEmail = email
            }
        }
        .navigationBarTitle("필수 정보 입력")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .backButtonArrow()
    }
}
