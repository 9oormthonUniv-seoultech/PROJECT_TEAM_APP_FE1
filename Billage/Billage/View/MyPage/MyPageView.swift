//
//  MyPageView.swift
//  Billage
//
//  Created by 변상우 on 11/4/24.
//

import SwiftUI

struct MyPageView: View {
    
    @EnvironmentObject var overlayManager: OverlayManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image("studing_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45)
                    .cornerRadius(30)
                    .padding(.leading, 10)
                    .padding(.vertical, 8)
                
                Text("Billage")
                    .font(.logo)
                    .foregroundStyle(.billageColor2)
                
                Spacer()
                
                NavigationLink {
                    
                } label: {
                    Image("search_button")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                }
                .padding(.trailing, 20)
            }
            .background(.billageColor1)
            
            ZStack {
                Image("studing_logo")
                    .resizable()
                    .frame(width: .screenWidth)
                    .scaledToFit()
                    .padding(.bottom, 20)
                
                VStack {
                    Text("김서영님, 빌리지와 12번의 강의실 예약을 함께했어요!")
                        .font(.option)
                        .foregroundStyle(Color.billGray1)
                        .padding(.top, 17)
                    
                    Spacer()
                }
            }
            .frame(height: 260)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("김서영")
                            .font(.bodysemibold)
                            .padding(.bottom, 9)
                        
                        Text("23100979")
                            .font(.option)
                        
                        Text("조형대학   시각디자인전공")
                            .font(.option)
                    }
                    .padding(.leading, 20)
                    .padding(.vertical, 18)
                    
                    Spacer()
                }
            }
            .foregroundStyle(Color.billGray1)
            .frame(maxWidth: .infinity)
            .background(Color.billWhg)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.billGray4, lineWidth: 2)
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("인증정보")
                            .font(.bodysemibold)
                            .padding(.bottom, 9)
                        
                        Text("010 - 1234 - 5678")
                            .font(.option)
                        
                        Text("billage1234@seoultech.ac.kr")
                            .font(.option)
                    }
                    .padding(.leading, 20)
                    .padding(.vertical, 18)
                    
                    Spacer()
                }
            }
            .foregroundStyle(Color.billGray1)
            .frame(maxWidth: .infinity)
            .background(Color.billWhg)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.billGray4, lineWidth: 2)
            )
            .padding(.horizontal, 20)
            
            Spacer()
            
            HStack {
                Button {
                    overlayManager.showSheet(
                        VStack(alignment: .center) {
                            VStack {
                                Text("로그아웃")
                                    .font(.bodybold)
                                    .padding(.top, 35)
                                    .padding(.bottom, 16)
                                
                                Text("로그아웃 하시겠습니까?")
                                    .font(.option)
                                    .foregroundStyle(Color.billGray1)
                            }
                            .padding(.bottom, 35)
                            
                            VStack(spacing: 8) {
                                Button {
                                    overlayManager.hideSheet()
                                    print("로그아웃처리!")
                                } label: {
                                    Text("로그아웃")
                                        .billageButtonModifier(width: .infinity, height: 44, isEnabled: true)
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
                        .padding(.horizontal, 21)
                    )
                } label: {
                    Text("로그아웃")
                        .font(.par)
                }
                
                Spacer()
                
                Button {
                    overlayManager.showSheet(
                        VStack(alignment: .center) {
                            VStack {
                                Text("회원탈퇴")
                                    .font(.bodybold)
                                    .padding(.top, 35)
                                    .padding(.bottom, 16)
                                
                                Text("탈퇴하시면 모든 정보가 삭제됩니다.\n탈퇴하시겠습니까?")
                                    .font(.option)
                                    .foregroundStyle(Color.billGray1)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.bottom, 35)
                            
                            VStack(spacing: 8) {
                                Button {
                                    overlayManager.hideSheet()
                                    print("탈퇴처리!")
                                } label: {
                                    Text("탈퇴")
                                        .billageButtonModifier(width: .infinity, height: 44, isEnabled: true)
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
                        .padding(.horizontal, 21)
                    )
                } label: {
                    Text("회원 탈퇴")
                        .font(.par)
                }
                
                Spacer()
                
                Button {
                    print("")
                } label: {
                    Text("문의하기")
                        .font(.par)
                }
            }
            .foregroundStyle(Color.billGray3)
            .padding(.horizontal, 20)
            .padding(.bottom, 18)
        }
    }
}

#Preview {
    MyPageView()
}
