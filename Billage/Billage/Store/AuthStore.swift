//
//  AuthStore.swift
//  Billage
//
//  Created by 변상우 on 9/23/24.
//

import Foundation

class AuthStore: ObservableObject {
    
    @Published var isHavingToken = false
    
    init() {
        if ((KeychainStore.sharedKeychain.getAccessToken() ?? "") == "" && (KeychainStore.sharedKeychain.getRefreshToken() ?? "") == "") {
            isHavingToken = false
        } else {
            isHavingToken = true
        }
    }
    
    let aToken: String = KeychainStore.sharedKeychain.getAccessToken() ?? ""
    let rToken: String = KeychainStore.sharedKeychain.getRefreshToken() ?? ""
    
}
