//
//  NavigationPathManager.swift
//  Billage
//
//  Created by 변상우 on 11/5/24.
//

import SwiftUI

class NavigationPathManager: ObservableObject {
    @Published var path = NavigationPath()
    
    func resetToRoot() {
        path = NavigationPath() // 경로를 빈 경로로 초기화
    }
}
