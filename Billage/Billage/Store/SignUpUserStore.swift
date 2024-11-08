//
//  SignUpUserStore.swift
//  Billage
//
//  Created by 변상우 on 11/7/24.
//

import Foundation
import SwiftUI
import Alamofire

enum SignUpCase {
    case success
    case already
    case fail
}

class SignUpUserStore: ObservableObject {
    
    static let shared = SignUpUserStore()
    
    @Published var signUpUser: SignUpUser
    @Published var showSignUpToast: Bool = false
    @Published var colleges: [CollegeInfo] = []
    
//    init() {
//        signUpUser = SignUpUser(name: "test", studentNumber: "18102001", password: "8020abcd*", phoneNumber: "010-0000-0000", college: "정보통신대학", major: "컴퓨터공학과", agreedToTerms: true, studentEmail: "test@naver.com")
//    }
    
    init() {
        signUpUser = SignUpUser(name: "", studentNumber: "", password: "", phoneNumber: "", college: "", major: "", agreedToTerms: false, studentEmail: "")
    }
    
    func postCreateUser(user: SignUpUser, completion: @escaping (SignUpCase) -> Void) {
        let url = "\(api_url)/api/v1/users/register"
        
        AF.request(url,
                   method: .post,
                   parameters: user,
                   encoder: JSONParameterEncoder.default
        )
        .responseDecodable(of: BaseResponse<EmptyData>.self) { response in
            switch response.result {
            case .success(let baseResponse):
                if baseResponse.status == 200 {
                    print("Response: \(baseResponse)")
                    completion(.success)
                } else if baseResponse.status == 409 {
                    print("Response: \(baseResponse)")
                    completion(.already)
                } else {
                    print("Response: \(baseResponse)")
                    completion(.fail)
                }
            case .failure(let error):
                print("회원가입 Error: \(error.localizedDescription)")
                completion(.fail)
            }
        }
    }
    
    func getDoubleCheckStudentNumber(studentNumber: String, completion: @escaping (Bool) -> Void) {
        let url = "\(api_url)/api/v1/users/check-student-number"
        
        let params = [
            "studentNumber": studentNumber
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: params,
                   headers: nil
        )
        .responseDecodable(of: BaseResponse<EmptyData>.self) { response in
            switch response.result {
            case .success(let baseResponse):
                if baseResponse.status == 200 {
                    print("Response: \(baseResponse)")
                    completion(true)
                } else if baseResponse.status == 409 {
                    print("Response: \(baseResponse)")
                    completion(false)
                } else {
                    print("Response: \(baseResponse)")
                    completion(false)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func getUnivCollege(completion: @escaping (Bool) -> Void) {
        let url = "\(api_url)/api/v1/univ/college"
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: nil
        )
        .responseDecodable(of: BaseResponse<[CollegeInfo]>.self) { response in
            switch response.result {
            case .success(let baseResponse):
                if baseResponse.status == 200 {
                    print("Response: \(baseResponse)")
                    if let data = baseResponse.data {
                        self.colleges = data
                        completion(true)
                    } else {
                        completion(false)
                    }
                } else if baseResponse.status == 409 {
                    print("Response: \(baseResponse)")
                    completion(false)
                } else {
                    print("Response: \(baseResponse)")
                    completion(false)
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func postEmailCertification(email: String, completion: @escaping (Bool) -> Void) {
        let url = "\(api_url)/api/v1/users/certificate"
        
        let params = [
            "email": email
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params
        )
        .responseDecodable(of: BaseResponse<EmptyData>.self) { response in
            switch response.result {
            case .success(let baseResponse):
                if baseResponse.status == 200 {
                    print("Response: \(baseResponse)")
                    completion(true)
                } else if baseResponse.status == 400 {
                    print("Response: \(baseResponse)")
                    completion(false)
                } else {
                    print("Response: \(baseResponse)")
                    completion(false)
                }
            case .failure(let error):
                print("회원가입 Error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func postEmailCodeVerification(email: String, codeNumber: Int, completion: @escaping (Bool) -> Void) {
        let url = "\(api_url)/api/v1/users/verify"
        
        let params = [
            "email": email,
            "codeNumber": codeNumber
        ] as [String : Any]
        
        AF.request(url,
                   method: .post,
                   parameters: params
        )
        .responseDecodable(of: BaseResponse<EmptyData>.self) { response in
            switch response.result {
            case .success(let baseResponse):
                if baseResponse.status == 200 {
                    print("Response: \(baseResponse)")
                    completion(true)
                } else if baseResponse.status == 400 {
                    print("Response: \(baseResponse)")
                    completion(false)
                } else {
                    print("Response: \(baseResponse)")
                    completion(false)
                }
            case .failure(let error):
                print("회원가입 Error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}
