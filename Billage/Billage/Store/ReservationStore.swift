//
//  ReservationStore.swift
//  Billage
//
//  Created by 변상우 on 11/8/24.
//

import Foundation
import Alamofire

class ReservationStore: ObservableObject {
    
    @Published var reservation: Reservation
    @Published var buildingList: [Building] = []
    @Published var classRoomList: [ClassRoom] = []
    @Published var classRoomDetailInfo: ClassRoomInfo
    
    @Published var currentReservation: CurrentReservation
    @Published var currentReservationList: [Reservations] = []
    @Published var totalReservationList: [Reservations] = []
    
    init() {
        reservation = Reservation(classroomId: 0, phoneNumber: "", applyDate: "", startTime: "", endTime: "", headcount: 0, purpose: "", contents: "")
        currentReservation = CurrentReservation(totalReservations: 0, totalPages: 0, reservations: [])
        classRoomDetailInfo = ClassRoomInfo(classroomId: 0, classroomName: "", classroomNumber: "", capacity: 0, description: "", classroomImages: [], reservationTimes: [])
    }
    
    func getUnivBuilding(date: String, headcount: Int, completion: @escaping (Bool) -> Void) {
        let url = "\(api_url)/api/v1/univ/building"
        
        let params = [
            "date": date,
            "headcount": headcount
        ] as [String : Any]
        
        AF.request(url,
                   method: .get,
                   parameters: params,
                   headers: nil
        )
        .responseDecodable(of: BaseResponse<[Building]>.self) { response in
            switch response.result {
            case .success(let baseResponse):
                if baseResponse.status == 200 {
                    print("Response: \(baseResponse)")
                    if let data = baseResponse.data {
                        self.buildingList = data
                        print(data)
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
    
    func getUnivClassRoom(buildingId: Int, floor: Int, date: String, headcount: Int, completion: @escaping (Bool) -> Void) {
        let url = "\(api_url)/api/v1/univ/classroom"
        
        let params = [
            "buildingId": buildingId,
            "floor": floor,
            "date": date,
            "headcount": headcount
        ] as [String : Any]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: nil
        )
        .responseDecodable(of: BaseResponse<[ClassRoom]>.self) { response in
            switch response.result {
            case .success(let baseResponse):
                if baseResponse.status == 200 {
                    print("Response: \(baseResponse)")
                    if let data = baseResponse.data {
                        self.classRoomList = data
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
    
    func getUnivClassRoomInfo(classroomId: Int, date: String, completion: @escaping (Bool) -> Void) {
        let url = "\(api_url)/api/v1/univ/classroom/info/\(classroomId)"
        
        let params = [
            "date": date
        ] as [String : Any]
        
        AF.request(url,
                   method: .get,
                   parameters: params,
                   headers: nil
        )
        .responseDecodable(of: BaseResponse<ClassRoomInfo>.self) { response in
            switch response.result {
            case .success(let baseResponse):
                if baseResponse.status == 200 {
                    print("Response: \(baseResponse)")
                    if let data = baseResponse.data {
                        self.classRoomDetailInfo = data
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
    
    func postReservations(classroomId: Int, phoneNumber: String, applyDate: String, startTime: String, endTime: String, headcount: Int, purpose: String, contents: String) {
        let url = "\(api_url)/api/v1/reservations"
        
        let header: HTTPHeaders = [
            "Authorization": "\(KeychainStore.sharedKeychain.getAccessToken() ?? "")"
        ]
        
        let params = [
            "classroomId": classroomId,
            "phoneNumber": phoneNumber,
            "applyDate": applyDate,
            "startTime": startTime,
            "endTime": endTime,
            "headcount": headcount,
            "purpose": purpose,
            "contents": contents
        ] as [String : Any]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: header
        )
        .responseDecodable(of: BaseResponse<EmptyData>.self) { response in
            switch response.result {
            case .success(let baseResponse):
                if baseResponse.status == 200 {
                    print("Response: \(baseResponse)")
                    if let data = baseResponse.data {
//                        self.currentReservation = data
//                        self.currentReservationList = data.reservations
                        print(data)
                    } else {
                    }
                } else if baseResponse.status == 400 {
                    print("Response: \(baseResponse)")
                } else {
                    print("Response: \(baseResponse)")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getReservationList(isPast: Bool, page: Int, completion: @escaping (Bool) -> Void) {
        let url = "\(api_url)/api/v1/reservations"
        
        let header: HTTPHeaders = [
            "Authorization": "\(KeychainStore.sharedKeychain.getAccessToken() ?? "")"
        ]
        
        let params = [
            "isPast": isPast,
            "page": page
        ] as [String : Any]
        
        AF.request(url,
                   method: .get,
                   parameters: params,
                   headers: header
        )
        .responseDecodable(of: BaseResponse<TotalReservations>.self) { response in
            print("response: \(response)")
            switch response.result {
            case .success(let baseResponse):
                if baseResponse.status == 200 {
                    print("Response: \(baseResponse)")
                    if let data = baseResponse.data {
                        self.totalReservationList = data.reservations
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
}
