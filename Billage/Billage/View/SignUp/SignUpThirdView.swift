//
//  SignUpThirdView.swift
//  Billage
//
//  Created by 변상우 on 9/23/24.
//

import SwiftUI

struct SignUpThirdView: View {
    
    @State private var selectedCollege = ""
    @State private var selectedMajor = ""
    @State private var isShowingCollegeBottomSheet = false
    @State private var isShowingMajorBottomSheet = false
    
    private var nextButtonStatus: Bool {
        return !selectedCollege.isEmpty && !selectedMajor.isEmpty ? true : false
    }
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    Text("소속 단과 대학")
                        .font(.bodysemibold)
                        .foregroundStyle(Color.billGray1)
                        .padding(.leading, 20)
                    
                    ZStack {
                        Button {
                            withAnimation {
                                isShowingCollegeBottomSheet = true
                            }
                        } label: {
                            Text(selectedCollege.isEmpty ? "선택하세요..." : selectedCollege)
                                .frame(maxWidth: .infinity, maxHeight: 52, alignment: .leading)
                                .font(.body)
                                .foregroundStyle(selectedCollege.isEmpty ? Color.billGray3 : Color.billGray1)
                                .padding(.leading, 14)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8) // 둥근 모서리 추가
                                        .stroke(selectedCollege.isEmpty ? Color.billGray3 : Color.billColor1, lineWidth: 1.5) // 테두리 색과 두께 설정
                                )
                        }
                        .contentShape(Rectangle())
                        
                        HStack(alignment: .center) {
                            Spacer()
                            
                            Image("arrow_drop_down")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32)
                                .padding(.trailing, 12)
                                .allowsHitTesting(false)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 30)
                .padding(.bottom, 20)
                
                VStack(alignment: .leading) {
                    Text("소속 학과")
                        .font(.bodysemibold)
                        .foregroundStyle(Color.billGray1)
                        .padding(.leading, 20)
                    
                    ZStack {
                        Button {
                            withAnimation {
                                isShowingMajorBottomSheet = true
                            }
                        } label: {
                            Text(selectedMajor.isEmpty ? "선택하세요..." : selectedMajor)
                                .frame(maxWidth: .infinity, maxHeight: 52, alignment: .leading)
                                .font(.body)
                                .foregroundStyle(selectedMajor.isEmpty ? Color.billGray3 : Color.billGray1)
                                .padding(.leading, 14)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8) // 둥근 모서리 추가
                                        .stroke(selectedMajor.isEmpty ? Color.billGray3 : Color.billColor1, lineWidth: 1.5) // 테두리 색과 두께 설정
                                )
                        }
                        .contentShape(Rectangle())
                        
                        HStack(alignment: .center) {
                            Spacer()
                            
                            Image("arrow_drop_down")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32)
                                .padding(.trailing, 12)
                                .allowsHitTesting(false)
                        }
                    }
                    .padding(.horizontal, 20)
                }
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
            
            BillageBottomSheet(isPresented: $isShowingCollegeBottomSheet) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("단과 대학을 선택해주세요")
                            .font(.bodybold)
                            .padding(.top, 35)
                            .padding(.bottom, 16)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Button {
                                selectedCollege = "공과대학"
                                
                                withAnimation {
                                    isShowingCollegeBottomSheet = false
                                }
                            } label: {
                                Text("공과대학")
                                    .font(.body)
                                    .foregroundStyle(Color.billGray1)
                            }
                            
                            Button {
                                selectedCollege = "기술경영융합대학"
                                
                                withAnimation {
                                    isShowingCollegeBottomSheet = false
                                }
                            } label: {
                                Text("기술경영융합대학")
                                    .font(.body)
                                    .foregroundStyle(Color.billGray1)
                            }
                            
                            Button {
                                selectedCollege = "조형대학"
                                
                                withAnimation {
                                    isShowingCollegeBottomSheet = false
                                }
                            } label: {
                                Text("조형대학")
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
            }
            
            BillageBottomSheet(isPresented: $isShowingMajorBottomSheet) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("학과를 선택해주세요")
                            .font(.bodybold)
                            .padding(.top, 35)
                            .padding(.bottom, 16)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Button {
                                selectedMajor = "ITM전공"
                                
                                withAnimation {
                                    isShowingMajorBottomSheet = false
                                }
                            } label: {
                                Text("ITM전공")
                                    .font(.body)
                                    .foregroundStyle(Color.billGray1)
                            }
                            
                            Button {
                                selectedMajor = "시각디자인학과"
                                
                                withAnimation {
                                    isShowingMajorBottomSheet = false
                                }
                            } label: {
                                Text("시각디자인학과")
                                    .font(.body)
                                    .foregroundStyle(Color.billGray1)
                            }
                            
                            Button {
                                selectedMajor = "컴퓨터공학과"
                                
                                withAnimation {
                                    isShowingMajorBottomSheet = false
                                }
                            } label: {
                                Text("컴퓨터공학과")
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
            }
        }
        .navigationBarTitle("필수 정보 입력")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .backButtonArrow()
    }
}

#Preview {
    SignUpThirdView()
}
