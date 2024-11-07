//
//  ClassRoomInfoView.swift
//  Billage
//
//  Created by 변상우 on 11/5/24.
//

import SwiftUI

struct ClassRoomInfoView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    private var nextButtonStatus: Bool {
        return true
    }
    
    var body: some View {
        VStack {
            BillageNavigationBar(title: "강의실 정보") {
                dismiss()
            }
            
            HStack {
                Text("602호")
                    .font(.head)
                    .foregroundStyle(Color.billGray1)
                
                Text("|  실험실  |  기준인원 30명")
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
                        ForEach(0..<16, id: \ .self) { slot in
                            Rectangle()
                                .fill(slot >= 5 && slot <= 7 ? Color.gray : Color.white)
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
                            
                            Text("빔 프로젝터, 컴퓨터, 사물함")
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
                ClassRoomApplyView()
            } label: {
                Text("신청하기")
                    .billageButtonModifier(width: .screenWidth * 0.9, height: 50, isEnabled: nextButtonStatus)
            }
            .padding(.vertical, 10)
            .disabled(!nextButtonStatus)
            .foregroundStyle(nextButtonStatus ? Color.billColor1 : Color.billGray3)
        }
        .navigationBarBackButtonHidden(true)
    }
}
