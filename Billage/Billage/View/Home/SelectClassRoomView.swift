//
//  SelectClassRoomView.swift
//  Billage
//
//  Created by 변상우 on 11/5/24.
//

import SwiftUI

struct SelectClassRoomView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedFloor: Int = 1
    @State private var selectedRoomIndex: Int? = nil
    @State private var selectedButtonIndex: Int? = nil
    
    private var nextButtonStatus: Bool {
        return true
    }
    
    var body: some View {
        VStack {
            BillageNavigationBar(title: "다빈치관(32)") {
                dismiss()
            }
            
            VStack {
                HStack {
                    Text("2024년 9월 10일")
                        .font(.head2)
                        .padding(.leading, 20)
                    
                    Spacer()
                }
                .frame(height: 44)
                
                Divider()
                    .foregroundStyle(.billageGray5)
                
                HStack(spacing: 6) {
                    ForEach(1..<7) { floor in
                        Button {
                            selectedFloor = floor
                        } label: {
                            Text("\(floor)층")
                                .font(.par)
                                .foregroundColor(selectedFloor == floor ? Color.billGray1 : Color.billGray3)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 12)
                                .background(selectedFloor == floor ? Color.billGray5 : .clear)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                Divider()
                    .foregroundStyle(.billageGray5)
            }
            .background(Color.whg)
            
            HStack(spacing: 0) {
                Text("사용 가능 시간")
                    .font(.sub)
                    .foregroundStyle(Color.billGray1)
                    .padding(.trailing, 12)
                
                Rectangle()
                    .fill(Color.wh)
                    .frame(width: 12, height: 12)
                    .overlay(
                        Rectangle()
                            .stroke(Color.billGray4, lineWidth: 1)
                    )
                
                Text("예약 불가 시간")
                    .font(.sub)
                    .foregroundStyle(Color.billGray1)
                    .padding(.leading, 27)
                
                Rectangle()
                    .fill(Color.billGray3)
                    .frame(width: 12, height: 12)
                    .padding(.leading, 12)
                
                Spacer()
            }
            .padding(.vertical, 12)
            .padding(.leading, 20)
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(0..<5, id: \ .self) { index in
                        VStack(alignment: .leading) {
                            HStack {
                                Text("602호")
                                    .font(.head)
                                    .foregroundStyle(Color.billGray1)
                                
                                Spacer()
                                
                                Text("실험실  |  기준인원 30명")
                                    .font(.body)
                                    .foregroundStyle(Color.billGray1)
                            }
                            .padding(.vertical, 11)
                            
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
                            .padding(.bottom, 19)
                        }
                        .padding(.horizontal, 15)
                        .background(selectedRoomIndex == index ? Color.billColor2 : Color.billGray4)
                        .cornerRadius(8)
                        .onTapGesture {
                            selectedRoomIndex = index
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .scrollIndicators(.hidden)
            
            Spacer()
            
            NavigationLink {
                ClassRoomInfoView()
            } label: {
                Text("다음으로")
                    .billageButtonModifier(width: .screenWidth * 0.9, height: 50, isEnabled: nextButtonStatus)
            }
            .padding(.vertical, 10)
            .disabled(!nextButtonStatus)
            .foregroundStyle(nextButtonStatus ? Color.billColor1 : Color.billGray3)
        }
        .background(Color.wh)
        .navigationBarBackButtonHidden(true)
    }
}
