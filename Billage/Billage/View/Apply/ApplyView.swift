//
//  ApplyView.swift
//  Billage
//
//  Created by 변상우 on 11/4/24.
//

import SwiftUI

struct ApplyView: View {
    
    @EnvironmentObject var reservationStore: ReservationStore
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
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
            
            BillageTopTabView(
                tabTitles: ["예약현황", "과거내역"], // 탭 타이틀 전달
                views: [
                    AnyView(CurrentView()), // 첫 번째 탭 콘텐츠
                    AnyView(HistoryView()) // 두 번째 탭 콘텐츠
                ],
                selectedTab: $selectedTab
            )
        }
        .onAppear {
            reservationStore.getReservationList(isPast: false, page: 1) { result in
                if result {
                    
                }
            }
        }
    }
}

#Preview {
    ApplyView()
}
