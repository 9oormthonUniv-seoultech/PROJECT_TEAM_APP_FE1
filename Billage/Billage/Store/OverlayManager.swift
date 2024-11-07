//
//  OverlayManager.swift
//  Billage
//
//  Created by 변상우 on 11/5/24.
//

import SwiftUI

class OverlayManager: ObservableObject {
    @Published var isSheetPresented: Bool = false
    @Published var sheetContent: AnyView? = nil
    @Published var offsetY: CGFloat = UIScreen.main.bounds.height // 애니메이션 위치 조정용
        
    func showSheet<Content: View>(_ content: Content) {
        sheetContent = AnyView(content)
        offsetY = UIScreen.main.bounds.height
        isSheetPresented = true
        withAnimation(.easeInOut(duration: 0.3)) {
            offsetY = 0 // 시트가 올라오는 애니메이션
        }
    }
    
    func hideSheet() {
        withAnimation(.easeInOut(duration: 0.3)) {
            offsetY = UIScreen.main.bounds.height // 시트가 내려가는 애니메이션
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.isSheetPresented = false
            self.sheetContent = nil
        }
    }
}

struct OverlayContainer: View {
    
    @EnvironmentObject var overlayManager: OverlayManager
    
    @State private var offsetY: CGFloat = UIScreen.main.bounds.height // 초기 위치를 화면 아래로 설정
    @State private var isAnimating = false // 애니메이션 중 여부
    
    var body: some View {
        ZStack {
            if overlayManager.isSheetPresented, let content = overlayManager.sheetContent {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        overlayManager.hideSheet() // 애니메이션과 함께 닫기
                    }
                
                VStack {
                    Spacer()
                    VStack {
                        content
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.billWh)
                    .cornerRadius(20)
                    .offset(y: overlayManager.offsetY)
                }
                .padding(.horizontal, 15)
            }
        }
    }
    
    func hideWithAnimation() {
        isAnimating = true
        withAnimation(.easeInOut(duration: 0.3)) {
            offsetY = UIScreen.main.bounds.height // 시트가 아래로 이동하도록 설정
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // 애니메이션 시간 이후에 시트를 숨김
            overlayManager.hideSheet()
            offsetY = UIScreen.main.bounds.height // 초기 위치로 리셋
            isAnimating = false
        }
    }
}
