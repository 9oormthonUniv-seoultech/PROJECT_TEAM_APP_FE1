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
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(authStore)
        }
    }
}
