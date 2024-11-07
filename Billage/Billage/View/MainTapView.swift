//
//  MainTapView.swift
//  Billage
//
//  Created by 변상우 on 11/4/24.
//

import SwiftUI

struct MainTapView: View {
    
    @State var selection: Int = 1
    @State private var rootSection1: Bool = false
    @State private var rootSection2: Bool = false
    @State private var rootSection3: Bool = false
    
    var selectionBinding: Binding<Int> { Binding (
        get: {
            self.selection
        },
        set: {
            if $0 == self.selection && rootSection1 {
                rootSection1 = false
            }
            if $0 == self.selection && rootSection2 {
                rootSection2 = false
            }
            if $0 == self.selection && rootSection3 {
                rootSection3 = false
            }
            self.selection = $0
        }
    )}
    
    var body: some View {
        TabView(selection: selectionBinding) {
            HomeView().tabItem {
                Image(selection == 1 ? "home_fill_tab" : "home_tab")
                Text("홈")
            }.tag(1)
            ApplyView().tabItem {
                Image(selection == 2 ? "apply_fill_tab" : "apply_tab")
                Text("신청현황")
            }.tag(2)
            MyPageView().tabItem {
                Image(selection == 3 ? "my_fill_tab" : "my_tab")
                Text("MY")
            }.tag(3)
        }
        .toolbarBackground(Color.billGray5, for: .tabBar)
        .font(.navigationbar)
        .tint(Color.billGray1)
    }
}

#Preview {
    MainTapView()
}
