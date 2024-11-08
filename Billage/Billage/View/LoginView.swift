//
//  LoginView.swift
//  Billage
//
//  Created by 변상우 on 9/23/24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authStore: AuthStore
    @EnvironmentObject var signUpUserStore: SignUpUserStore
    @EnvironmentObject var navigationPathManager: NavigationPathManager
    
    @State private var id: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack(path: $navigationPathManager.path) {
            VStack {
                Spacer()
                
                Image("studing_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 145)
                    .cornerRadius(30)
                
                Text("빌리지로 어서오세요!")
                    .font(.head)
                    .foregroundStyle(Color.billGray1)
                    .padding(.top, 37)
                    .padding(.bottom, 3)
                
                Text("서울과학기술대학교 강의실 대여 서비스")
                    .font(.par)
                    .foregroundStyle(.black)
                
                Spacer()
                
                VStack(spacing: 12) {
                    TextField("아이디(학번)", text: $id)
                        .billageTextFieldModifier(width: .screenWidth * 0.9, height: 52)
                        .font(.body)
                        .foregroundStyle(Color.billGray1)
                    
                    SecureField("비밀번호", text: $password)
                        .billageTextFieldModifier(width: .screenWidth * 0.9, height: 52)
                        .font(.body)
                        .foregroundStyle(Color.billGray1)
                        .textContentType(.oneTimeCode)
                }
                .padding(.bottom, 16)
                
                Button {
                    authStore.login(studentNumber: id, password: password) { result in
                        if result {
                            authStore.isHavingToken = true
                        }
                    }
                } label: {
                    Text("로그인")
                        .billageButtonModifier(width: .screenWidth * 0.9, height: 50, isEnabled: true)
                }
                .padding(.bottom, 14)
                
                HStack(alignment: .center, spacing: 20) {
                    Button {
                        print("비밀번호 찾기")
                    } label: {
                        Text("비밀번호 찾기")
                            .font(.par)
                            .foregroundStyle(Color.billGray1)
                    }
                    
                    NavigationLink(value: "TEST") {
                        Text("회원가입 하기")
                            .font(.par)
                            .foregroundStyle(Color.billGray1)
                    }
                    .navigationDestination(for: String.self) { value in
                        SignUpFirstView()
                    }
                }
                
                Spacer()
                
                HStack(alignment: .center, spacing: 25) {
                    Text("Copyright © 9oormiz2024. All rights reserved.")
                        .font(.sub)
                        .foregroundStyle(Color.billGray3)
                    
                    Text("문의하기")
                        .font(.par)
                        .foregroundStyle(Color.billGray1)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
