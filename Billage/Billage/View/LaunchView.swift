//
//  LaunchView.swift
//  Billage
//
//  Created by 변상우 on 9/10/24.
//

import SwiftUI

struct LaunchView: View {
    
    init() {
        let customFont = UIFont(name: "Pretendard-SemiBold", size: 20) ?? UIFont.systemFont(ofSize: 20)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 배경 색을 불투명하게 설정
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(Color.billGray1), // 글씨 색 설정
            .font: customFont // 폰트 설정
        ]
        
        // 네비게이션 바 전체에 적용
        UINavigationBar.appearance().standardAppearance = appearance
        
        // 탭 바 전체에 적용
        UITabBar.appearance().backgroundColor = UIColor(Color.white)
    }
    
    @EnvironmentObject var authStore: AuthStore
    
    @State private var isActive = false
    @State private var isLoading = true
    
    var body: some View {
        if isActive {
            if authStore.isHavingToken {
                MainView()
            } else {
                LoginView()
            }
        } else {
            if isLoading {
                ZStack {
                    Color.billColor1
                    
                    VStack {
                        Spacer()
                        
                        Image("studing_logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 220)
                            .padding(.bottom, 96)
                        
                        Text("빌리지로 어서오세요!")
                            .font(.head)
                            .foregroundStyle(.wh)
                            .padding(.bottom, 3)
                        
                        Text("서울과학기술대학교 강의실 대여 서비스")
                            .font(.par)
                            .foregroundStyle(.wh)
                        
                        Spacer()
                    }
                }
                .ignoresSafeArea()
                
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation {
                            self.isActive = true
                            self.isLoading.toggle()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchView()
}
