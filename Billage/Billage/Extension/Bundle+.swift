//
//  Bundle+.swift
//  Billage
//
//  Created by 변상우 on 9/21/24.
//

import Foundation

extension Bundle {
    var api_url: String {
        guard let file = self.path(forResource: "Info", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["API_BASE_URL"] as? String else { fatalError("api base url 설정 안됨") }
        
        return key
    }
}
