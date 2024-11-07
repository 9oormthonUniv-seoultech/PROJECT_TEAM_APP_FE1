//
//  BillageTopTabView.swift
//  Billage
//
//  Created by 변상우 on 11/5/24.
//

import SwiftUI

struct BillageTopTabView<Content: View>: View {
    let tabTitles: [String] // 탭 타이틀 리스트
    let views: [Content] // 각 탭에 대한 뷰 리스트
    @Binding var selectedTab: Int // 선택된 탭 인덱스
    @Namespace private var animation
    
    var body: some View {
        VStack {
            // Custom Tab Bar
            HStack {
                ForEach(tabTitles.indices, id: \.self) { index in
                    VStack {
                        Text(tabTitles[index])
                            .font(selectedTab == index ? .bodysemibold : .option)
                            .foregroundColor(selectedTab == index ? .billGray1 : .billGray3)
                            .frame(height: 40)
                            .onTapGesture {
                                withAnimation {
                                    selectedTab = index
                                }
                            }
                        
                        if selectedTab == index {
                            Color.billGray2
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "tabIndicator", in: animation)
                        } else {
                            Color.clear.frame(height: 2)
                        }
                    }
                }
            }
            
            // Views for Tabs
            TabView(selection: $selectedTab) {
                ForEach(views.indices, id: \.self) { index in
                    views[index]
                        .tag(index)
                        .gesture(DragGesture()
                                    .onEnded { value in
                                        if value.translation.width < 0 && index < views.count - 1 {
                                            withAnimation {
                                                selectedTab = index + 1
                                            }
                                        } else if value.translation.width > 0 && index > 0 {
                                            withAnimation {
                                                selectedTab = index - 1
                                            }
                                        }
                                    })
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}
