//
//  SignUpUser.swift
//  Billage
//
//  Created by 변상우 on 11/7/24.
//

import SwiftUI

struct SignUpUser: Encodable {
    var name: String
    var studentNumber: String
    var password: String
    var phoneNumber: String
    var college: String
    var major: String
    var agreedToTerms: Bool
    var studentEmail: String
}

// 학부 정보 구조체
struct CollegeInfo: Decodable, Hashable {
    let college: String
    let majors: [String]
}
