//
//  LoginResponse.swift
//  Billage
//
//  Created by 변상우 on 11/8/24.
//

import Foundation

struct LoginResponse: Decodable, Hashable {
    let authorization: String
    let refreshToken: String
}
