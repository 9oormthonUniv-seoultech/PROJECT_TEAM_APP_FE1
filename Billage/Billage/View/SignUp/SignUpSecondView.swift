//
//  SignUpSecondView.swift
//  Billage
//
//  Created by 변상우 on 9/23/24.
//

import SwiftUI

enum PasswordCountStatus {
    case empty
    case valid
    case invalid
}

enum PasswordSpecialCharacterStatus {
    case empty
    case valid
    case invalid
}

struct SignUpSecondView: View {
    
    @State private var password: String = ""
    @State private var passwordCheck: String = ""
    
    @State private var isShowingPassword: Bool = false
    @State private var isShowingPasswordCheck: Bool = false
    
    @State private var passwordCountStatus: PasswordCountStatus = .empty
    @State private var passwordSpecialCharacterStatus: PasswordSpecialCharacterStatus = .empty
    
    private var isPasswordCorrect: Bool {
        return passwordCountStatus == .valid && passwordSpecialCharacterStatus == .valid ? true : false
    }
    
    private var isPasswordCheckCorrect: Bool {
        return password == passwordCheck ? true : false
    }
    
    private var nextButtonStatus: Bool {
        if password == "" { return false }
        return isPasswordCorrect && isPasswordCheckCorrect ? true : false
    }
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    if isShowingPassword {
                        TextField("비밀번호", text: $password)
                            .billageTextFieldModifier(width: .screenWidth * 0.9, height: 52)
                            .font(.body)
                            .foregroundStyle(Color.billGray1)
                            .onChange(of: password) {
                                passwordCountStatus = checkPasswordLength(password)
                                passwordSpecialCharacterStatus = checkSpecialCharacter(password)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8) // 둥근 모서리 추가
                                    .stroke(isPasswordCorrect ? Color.billColor1 : Color.billGray3, lineWidth: 1.5) // 테두리 색과 두께 설정
                            )
                    } else {
                        SecureField("비밀번호", text: $password)
                            .billageTextFieldModifier(width: .screenWidth * 0.9, height: 52)
                            .font(.body)
                            .foregroundStyle(Color.billGray1)
                            .onChange(of: password) {
                                passwordCountStatus = checkPasswordLength(password)
                                passwordSpecialCharacterStatus = checkSpecialCharacter(password)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 8) // 둥근 모서리 추가
                                    .stroke(isPasswordCorrect ? Color.billColor1 : Color.billGray3, lineWidth: 1.5) // 테두리 색과 두께 설정
                            )
                    }
                }
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    Button {
                        isShowingPassword.toggle()
                    } label: {
                        Image(isShowingPassword ? "eye_open" : "eye_close")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 23)
                            .padding(.trailing, 43)
                    }
                }
            }
            .padding(.top, 30)
            
            VStack {
                HStack {
                    if (passwordCountStatus == .empty) {
                        Text("영문 8~16 자리")
                            .font(.par)
                            .foregroundStyle(Color.billGray3)
                    } else {
                        Text("영문 8~16 자리")
                            .font(.par)
                            .foregroundStyle(passwordCountStatus == .valid ? Color.billColor1 : Color.billError)
                    }
                    
                    Spacer()
                }
                
                HStack {
                    if (passwordSpecialCharacterStatus == .empty) {
                        Text("특수문자 1개 이상 포함")
                            .font(.par)
                            .foregroundStyle(Color.billGray3)
                    } else {
                        Text("특수문자 1개 이상 포함")
                            .font(.par)
                            .foregroundStyle(passwordSpecialCharacterStatus == .valid ? Color.billColor1 : Color.billError)
                    }
                    
                    Spacer()
                }
            }
            .padding(.leading, 36)
            .padding(.bottom, 30)
            
            ZStack {
                VStack {
                    if isShowingPasswordCheck {
                        TextField("비밀번호 확인", text: $passwordCheck)
                            .billageTextFieldModifier(width: .screenWidth * 0.9, height: 52)
                            .font(.body)
                            .foregroundStyle(Color.billGray1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8) // 둥근 모서리 추가
                                    .stroke(isShowingPasswordCheck ? Color.billColor1 : Color.billGray3, lineWidth: 1.5) // 테두리 색과 두께 설정
                            )
                    } else {
                        SecureField("비밀번호 확인", text: $passwordCheck)
                            .billageTextFieldModifier(width: .screenWidth * 0.9, height: 52)
                            .font(.body)
                            .foregroundStyle(Color.billGray1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8) // 둥근 모서리 추가
                                    .stroke(isShowingPasswordCheck ? Color.billColor1 : Color.billGray3, lineWidth: 1.5) // 테두리 색과 두께 설정
                            )
                    }
                }
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    Button {
                        isShowingPasswordCheck.toggle()
                    } label: {
                        Image(isShowingPasswordCheck ? "eye_open" : "eye_close")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 23)
                            .padding(.trailing, 43)
                    }
                }
            }
            
            VStack {
                HStack {
                    if (passwordCheck == "") {
                        Text("동일한 비밀번호를 입력해주세요")
                            .font(.par)
                            .foregroundStyle(Color.billGray3)
                    } else {
                        Text(passwordCheck == password ? "비밀번호 확인 완료" : "비밀번호가 틀립니다")
                            .font(.par)
                            .foregroundStyle(nextButtonStatus ? Color.billColor1 : Color.billError)
                    }
                    
                    Spacer()
                }
            }
            .padding(.leading, 36)
            
            Spacer()
            
            NavigationLink {
                SignUpThirdView()
            } label: {
                Text("다음으로")
                    .billageButtonModifier(width: .screenWidth * 0.9, height: 50, isEnabled: nextButtonStatus)
            }
            .padding(.bottom, 40)
            .disabled(!nextButtonStatus)
            .foregroundStyle(nextButtonStatus ? Color.billColor1 : Color.billGray3)
        }
        .navigationBarTitle("필수 정보 입력")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .backButtonArrow()
    }
    
    private func checkPasswordLength(_ password: String) -> PasswordCountStatus {
        if password.isEmpty {
            return .empty
        } else if password.count >= 8 && password.count <= 16 {
            return .valid
        } else {
            return .invalid
        }
    }
    
    private func checkSpecialCharacter(_ password: String) -> PasswordSpecialCharacterStatus {
        if password.isEmpty {
            return .empty
        }
        
        let specialCharacterRegex = ".*[^A-Za-z0-9].*"
        let hasSpecialCharacterTest = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex)
        return hasSpecialCharacterTest.evaluate(with: password) ? .valid : .invalid
    }
    
    private func borderColor(for status: PasswordCountStatus) -> Color {
        switch status {
        case .empty:
            return Color.billGray3
        case .valid:
            return Color.billColor1
        case .invalid:
            return Color.billError
        }
    }
}

#Preview {
    SignUpSecondView()
}
