//
//  Reservation.swift
//  Billage
//
//  Created by 변상우 on 11/6/24.
//

import Foundation

struct Reservation: Encodable, Hashable {
    var classroomId: Int
    var phoneNumber: String
    var applyDate: String
    var startTime: String
    var endTime: String
    var headcount: Int
    var purpose: String
    var contents: String
}

struct Building: Decodable, Hashable {
    let buildingId: Int
    let buildingName: String
    let buildingNumber: String
    let floors: [Int]
}

struct CurrentReservation: Decodable, Hashable {
    let totalReservations: Int
    let totalPages: Int
    let reservations: [Reservations]
}

struct Reservations: Decodable, Hashable {
    let reservationId: Int
    let applyDate: String
    let startTime: String
    let endTime: String
    let headcount: Int
    let classroomName: String
    let classroomNumber: String
    let reservationStatus: String
    let rejectionReason: String?
    let adminPhoneNumber: String
}

struct ClassRoom: Decodable, Hashable {
    let classroomId: Int
    let classroomName: String
    let classroomNumber: String
    let capacity: Int
    let reservationTimes: [ReservationTime]
}

struct ClassRoomInfo: Decodable, Hashable {
    let classroomId: Int
    let classroomName: String
    let classroomNumber: String
    let capacity: Int
    let description: String
    let classroomImages: [String]
    let reservationTimes: [ReservationTime]
}

struct ReservationTime: Decodable, Hashable {
    let startTime: String
    let endTime: String
}

struct TotalReservations: Decodable, Hashable {
    let totalReservations: Int
    let totalPages: Int
    let reservations: [Reservations]
}
