//
//  BillageApp.swift
//  Billage
//
//  Created by 변상우 on 9/10/24.
//

import SwiftUI

@main
struct BillageApp: App {
    
    @ObservedObject var authStore = AuthStore()
    @ObservedObject private var navigationPathManager = NavigationPathManager()
    
    @StateObject private var overlayManager = OverlayManager()
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(authStore)
                .environmentObject(overlayManager)
                .environmentObject(navigationPathManager)
                .overlay(OverlayContainer().environmentObject(overlayManager))
        }
    }
}
