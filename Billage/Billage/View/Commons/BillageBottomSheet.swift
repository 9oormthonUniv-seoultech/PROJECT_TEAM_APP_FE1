//
//  BillageBottomSheet.swift
//  Billage
//
//  Created by 변상우 on 10/2/24.
//

import SwiftUI

struct BillageBottomSheet<Content: View>: View {
    
    @Binding var isPresented: Bool
    
    let content: () -> Content
    
    var body: some View {
        ZStack {
            if isPresented {
                Color.billGray1.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
            }
            
            VStack {
                Spacer()

                // 바텀 시트
                VStack {
                    content() // 재사용 가능한 컨텐츠
                }
                .frame(maxWidth: .infinity)
                .background(Color.billWh)
                .cornerRadius(20)
                .offset(y: isPresented ? 0 : UIScreen.main.bounds.height)
                .animation(.easeInOut, value: isPresented)
            }
            .padding(.horizontal, 15)
        }
    }
}
