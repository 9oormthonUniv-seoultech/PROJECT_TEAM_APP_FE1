//
//  MainView.swift
//  Billage
//
//  Created by 변상우 on 9/23/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var navigationPathManager: NavigationPathManager
    
    @State private var count: Int = 1
    @State private var selectedButtonIndex: Int? = nil
    
    private var nextButtonStatus: Bool {
        return true
    }
    
    var body: some View {
        NavigationStack(path: $navigationPathManager.path) {
            VStack(spacing: 0) {
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
                
                HStack {
                    ZStack {
                        BillageDatePickerScrollView()
                        
                        HStack {
                            Spacer()
                            
                            VStack {
                                Image("calendar_button")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 32)
                                    .padding(14)
                            }
                            .background(.whg)
                            .overlay(
                                Rectangle()
                                    .frame(width: 1.5)
                                    .foregroundColor(.billageGray4),
                                alignment: .leading // 왼쪽 정렬
                            )
                        }
                        .zIndex(1)
                    }
                }
                .frame(height: 60)
                .background(Color.billWhg)
                .overlay(
                    Rectangle()
                        .frame(height: 1.5)
                        .foregroundColor(.billageGray4),
                    alignment: .bottom // 왼쪽 정렬
                )
                
                HStack {
                    Text("희망 인원")
                        .font(.bodysemibold)
                        .foregroundStyle(.billageGray1)
                        .padding(.top, 5)
                    
                    Spacer()
                    
                    ZStack {
                        HStack {
                            Spacer()
                            
                            Button {
                                if count > 1 {
                                    count -= 1
                                }
                            } label: {
                                Image(systemName: "minus")
                                    .frame(width: 14)
                                    .foregroundColor(Color.billageGray3)
                            }
                            .frame(height: 34)
                            
                            Spacer()
                            
                            Text("\(count)")
                                .font(.option)
                                .foregroundStyle(Color.billGray1)
                                .frame(width: 34, height: 34)
                                .multilineTextAlignment(.center)
                                .background(Color.billWh)
                                .zIndex(1)
                            
                            Spacer()
                            
                            Button {
                                count += 1
                            } label: {
                                Image(systemName: "plus")
                                    .frame(width: 14)
                                    .foregroundColor(Color.billageGray3)
                            }
                            .frame(height: 34)
                            
                            Spacer()
                        }
                    }
                    .frame(width: 102, height: 34)
                    .background(Color.billGray5)
                    .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(Color.billWhg)
                
                ScrollView {
                    Image("studing_logo")
                        .resizable()
                        .frame(width: .screenWidth)
                        .scaledToFit()
                        .padding(.bottom, 20)
                    
                    VStack(spacing: 10) {
                        ForEach(0..<20, id: \.self) { index in
                            Button {
                                selectedButtonIndex = index
                            } label: {
                                HStack {
                                    Text("1")
                                        .padding(.leading, 25)
                                    
                                    Text("대학 본부")
                                        .padding(.leading, 36)
                                    
                                    Spacer()
                                }
                            }
                            .font(.option)
                            .foregroundColor(.billGray1)
                            .frame(height: 54)
                            .background(Color.billGray4)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedButtonIndex == index ? Color.billColor1 : .clear, lineWidth: 2)
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .scrollIndicators(.hidden)
                
                Spacer()
                
                NavigationLink(value: "TEST") {
                    Text("다음으로")
                        .billageButtonModifier(width: .screenWidth * 0.9, height: 50, isEnabled: nextButtonStatus)
                }
                .padding(.vertical, 10)
                .disabled(!nextButtonStatus)
                .foregroundStyle(nextButtonStatus ? Color.billColor1 : Color.billGray3)
                .navigationDestination(for: String.self) { value in
                    SelectClassRoomView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
