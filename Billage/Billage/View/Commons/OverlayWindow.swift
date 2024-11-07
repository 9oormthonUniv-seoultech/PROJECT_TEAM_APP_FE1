//
//  OverlayWindow.swift
//  Billage
//
//  Created by 변상우 on 11/5/24.
//

import SwiftUI
import UIKit

class OverlayWindow: UIWindow {
    static let shared = OverlayWindow(frame: UIScreen.main.bounds) // frame 전달
    
    private override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.windowLevel = .alert + 1 // 윈도우 레벨을 최상위로 설정
        self.rootViewController = UIHostingController(rootView: EmptyView())
        self.isHidden = true // 처음에는 숨김 처리
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // SwiftUI 뷰를 최상단에 표시하는 메서드
    func show<Content: View>(_ view: Content) {
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.backgroundColor = .clear
        self.rootViewController = hostingController
        self.isHidden = false
        self.makeKeyAndVisible() // 윈도우를 최상단에 표시
    }
    
    // 윈도우를 숨기는 메서드
    func hide() {
        self.isHidden = true
        self.rootViewController = nil
    }
}
