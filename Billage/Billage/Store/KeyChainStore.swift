//
//  KeyChainStore.swift
//  Billage
//
//  Created by 변상우 on 9/23/24.
//

import Foundation
import SwiftKeychainWrapper

class KeychainStore {
    
    static let sharedKeychain = KeychainStore()
    
    func saveAccessToken(_ token: String) {
        KeychainWrapper.standard.set(token, forKey: "ACCESS_TOKEN")
    }
    
    func saveRefreshToken(_ token: String) {
        KeychainWrapper.standard.set(token, forKey: "REFRESH_TOKEN")
    }
    
    func saveFcmToken(_ token: String) {
        KeychainWrapper.standard.set(token, forKey: "FCM_TOKEN")
    }
    
    func getAccessToken() -> String? {
        return KeychainWrapper.standard.string(forKey: "ACCESS_TOKEN")
    }
    
    func getRefreshToken() -> String? {
        return KeychainWrapper.standard.string(forKey: "REFRESH_TOKEN")
    }
    
    func getFcmToken() -> String? {
        return KeychainWrapper.standard.string(forKey: "FCM_TOKEN")
    }
    
    func resetAllToken() {
        self.saveAccessToken("")
        self.saveRefreshToken("")
        self.saveFcmToken("")
    }
    
}
