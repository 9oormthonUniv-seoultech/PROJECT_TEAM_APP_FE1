//
//  AuthStore.swift
//  Billage
//
//  Created by 변상우 on 9/23/24.
//

import Foundation
import Alamofire

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
    
    func login(studentNumber: String, password: String, completion: @escaping (Bool) -> Void) {
        let url = "\(api_url)/api/v1/users/login"
        
        let fcmToken = KeychainStore.sharedKeychain.getFcmToken() ?? ""
        
        let params = [
            "studentNumber": studentNumber,
            "password": password,
            "fcmtoken": fcmToken
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder.default
        ).responseDecodable(of: BaseResponse<LoginResponse>.self) { response in
            switch response.result {
            case .success(let loginResult):
                if loginResult.status == 200 {
                    print("Response: \(loginResult)")
                    print("로그인 성공!")
                    KeychainStore.sharedKeychain.saveAccessToken(loginResult.data?.authorization ?? "")
                    KeychainStore.sharedKeychain.saveRefreshToken(loginResult.data?.refreshToken ?? "")
                    
                    print("\(loginResult.data?.authorization ?? "")")
                    print("\(loginResult.data?.refreshToken ?? "")")
                    completion(true)
                } else if loginResult.status == 401 {
                    print("Response: \(loginResult)")
                    print("회원정보가 일치하지 않습니다.")
                    completion(false)
                } else {
                    print("Response: \(loginResult)")
                    print("실패!")
                    completion(false)
                }
            case .failure(let error):
                print("로그인 Error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func logout(completion: @escaping (Bool) -> Void) {
        print("----------logout----------")
        let url = "\(api_url)/api/v1/users/logout"
        
        let header: HTTPHeaders = [
            "Authorization": "\(KeychainStore.sharedKeychain.getAccessToken() ?? "")",
            "RefreshToken": "\(KeychainStore.sharedKeychain.getRefreshToken() ?? "")"
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: nil,
                   headers: header
        ).responseDecodable(of: BaseResponse<EmptyData>.self) { response in
            switch response.result {
            case .success(let result):
                if result.status == 200 {
                    print("Response: \(result)")
                    print("로그아웃 성공!")
                    self.isHavingToken = false
                    KeychainStore.sharedKeychain.resetAllToken()
                    completion(true)
                } else if result.status == 401 {
                    print("Response: \(result)")
                    self.getNewAccessToken { result in
                        if result {
                            self.logout { _ in
                                print("AccessToken 재발급 이후 로그아웃 성공")
                            }
                        }
                    }
                    print("회원정보가 일치하지 않습니다.")
                    completion(false)
                } else {
                    print("Response: \(result)")
                    print("실패!")
                    completion(false)
                }
            case .failure(let error):
                print("로그아웃 Error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func getNewAccessToken(completion: @escaping (Bool) -> Void) {
        print("----------getNewAccessToken----------")
        let url = "\(api_url)/api/auth/refresh-token"
        
        let params = [
            "refreshToken": "\(KeychainStore.sharedKeychain.getRefreshToken() ?? "")"
        ]
        
        let header: HTTPHeaders = [
            "Authorization": "\(KeychainStore.sharedKeychain.getAccessToken() ?? "")",
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: header
        ).responseDecodable(of: BaseResponse<EmptyData>.self) { response in
            switch response.result {
            case .success(let authResult):
                print("Response: \(authResult)")
                if authResult.status == 200 {
                    print("AccessToken 재발급 성공")
//                    KeychainStore.sharedKeychain.saveAccessToken(authResult.data![0].access_token)
                    completion(true)
                } else if authResult.status == 403 {
                    print("유효하지 않은 RefreshToken입니다.")
                    self.isHavingToken = false
                    
                    completion(false)
                } else {
                    print("실패!")
                    completion(false)
                }
            case .failure(let error):
                print("getNewAccessToken Error: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}
