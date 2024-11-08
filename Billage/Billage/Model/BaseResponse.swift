//
//  BaseResponse.swift
//  Billage
//
//  Created by 변상우 on 11/7/24.
//

import Foundation

// 공통 응답 구조체
struct BaseResponse<T: Decodable>: Decodable {
    let success: Bool
    let status: Int
    let data: T?
    let code: String?
    let reason: String?
    let timeStamp: String?
    let path: String?
}

// 빈 데이터 구조체
struct EmptyData: Decodable {}
