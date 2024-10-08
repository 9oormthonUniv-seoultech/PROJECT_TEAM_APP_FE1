//
//  SignUpFifthView.swift
//  Billage
//
//  Created by 변상우 on 10/3/24.
//

import SwiftUI

struct SignUpFifthView: View {
    
    @State private var firstAgreement: Bool = false
    @State private var secondAgreement: Bool = false
    
    private var allAgreement: Bool {
        return firstAgreement && secondAgreement ? true : false
    }
    
    private var nextButtonStatus: Bool {
        return allAgreement ? true : false
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Image("studing_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 110)
                    .cornerRadius(30)
                
                Text("빌리지에 어서오세요!")
                    .font(.head)
                    .foregroundStyle(.billageGray1)
                    .padding(.top, 20)
            }
            .padding(.top, 35)
            .padding(.leading, 42)
            
            Spacer()
            
            VStack {
                HStack {
                    Button {
                        firstAgreement.toggle()
                    } label: {
                        Image(firstAgreement ? "check_active" : "check_inactive")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18)
                    }
                    
                    Text("서비스 이용약관 동의(필수)")
                        .font(.par)
                        .foregroundStyle(.billageGray1)
                    
                    Spacer()
                    
                    NavigationLink {
//                        PDFViewWrapper(pdfFileName: "TermsOfService")
//                            .navigationTitle("서비스 이용약관")
//                            .navigationBarBackButtonHidden(true)
//                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Image("arrow_right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 26)
                    }
                }
                
                HStack {
                    Button {
                        secondAgreement.toggle()
                    } label: {
                        Image(secondAgreement ? "check_active" : "check_inactive")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18)
                    }
                    
                    Text("개인정보 수집 및 이용동의 (필수)")
                        .font(.par)
                        .foregroundStyle(.billageGray1)
                    
                    Spacer()
                    
                    NavigationLink {
//                        PDFViewWrapper(pdfFileName: "TermsOfService")
//                            .navigationTitle("서비스 이용약관")
//                            .navigationBarBackButtonHidden(true)
//                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Image("arrow_right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 26)
                    }
                }
                Divider()
                    .foregroundStyle(.billageGray5)
            }
            .padding(.leading, 42)
            .padding(.trailing, 33)
            
            HStack {
                Button {
                    if allAgreement {
                        firstAgreement = false
                        secondAgreement = false
                    } else {
                        firstAgreement = true
                        secondAgreement = true
                    }
                } label: {
                    Image(firstAgreement && secondAgreement ? "check_box_fill" : "check_box")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24)
                }
                
                Text("전체 동의")
                    .font(.option)
                    .foregroundStyle(.billageGray1)
            }
            .padding(.top, 20)
            .padding(.leading, 42)
            
            Spacer()
            
            NavigationLink {
                SignUpFifthView()
            } label: {
                Text("다음으로")
                    .billageButtonModifier(width: .screenWidth * 0.9, height: 50, isEnabled: nextButtonStatus)
            }
            .padding(.bottom, 40)
            .padding(.horizontal, 20)
            .disabled(!nextButtonStatus)
            .foregroundStyle(nextButtonStatus ? Color.billColor1 : Color.billGray3)
        }
        .navigationBarTitle("서비스 정책 동의")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .backButtonArrow()
    }
}

#Preview {
    SignUpFifthView()
}
