//
//  ReservationView.swift
//  Billage
//
//  Created by 변상우 on 11/6/24.
//

import SwiftUI

struct ReservationView: View {
    
    var reservation: Reservations
    
    var onCancelReservation: (() -> Void)?
    var onViewRejectionReason: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(reservation.reservationStatus)
                    .font(.bodybold)
                    .foregroundColor(statusFontColor(status: reservation.reservationStatus))
                    .frame(width: 72, height: 36)
                    .background(statusColor(status: reservation.reservationStatus))
                    .cornerRadius(12)
                
                Spacer()
            }
            .padding(.top, 15)
            .padding(.leading, 15)
            .padding(.bottom, 11)
            
            VStack(spacing: 8) {
                HStack(spacing: 10) {
                    Text(formatDate(reservation.applyDate) ?? "")
                        .frame(width: 189)
                        .reservationBackgroundModifier()
                    
                    Text("\(reservation.headcount) 명")
                        .frame(maxWidth: .infinity)
                        .reservationBackgroundModifier()
                }
                
                HStack(spacing: 10) {
                    Text(reservation.classroomName)
                        .frame(width: 189)
                        .reservationBackgroundModifier()
                    
                    Text(reservation.classroomNumber)
                        .frame(maxWidth: .infinity)
                        .reservationBackgroundModifier()
                }
                
                Text("\(reservation.startTime) ~ \(reservation.endTime)")
                    .frame(maxWidth: .infinity)
                    .reservationBackgroundModifier()
            }
            .font(.option)
            .foregroundStyle(Color.billGray1)
            .padding(.horizontal, 14)
            .padding(.bottom, 24)
            
            if reservation.reservationStatus == "예약 거절" {
                HStack {
                    Spacer()
                    
                    Button {
                        onViewRejectionReason?()
                    } label: {
                        Text("거절 사유 확인하기")
                            .billageButtonModifier(width: .screenWidth * 0.7, height: 45, isEnabled: true)
                    }
                    .padding(.bottom, 18)
                    
                    Spacer()
                }
            }
            
            HStack {
                Text("문의 \(reservation.adminPhoneNumber)")
                    .font(.sub)
                    .foregroundStyle(Color.billGray1)
                    .padding(.leading, 15)
                
                Spacer()
                
                if reservation.reservationStatus != "학생 취소" {
                    Button {
                        onCancelReservation?()
                    } label: {
                        Text("예약 취소")
                            .font(.par)
                            .foregroundStyle(Color.billGray1)
                            .padding(.trailing, 14)
                    }
                }
            }
            .padding(.bottom, 11)
        }
        .background(Color.billWh)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.billGray5, lineWidth: 2)
        )
    }
    
    func statusFontColor(status: String) -> Color {
        switch status {
        case "예약 승인", "예약 거절", "학생 취소" :
            return Color.billWh
        case "예약 대기":
            return Color.billGray1
        default:
            return Color.clear
        }
    }
    
    func statusColor(status: String) -> Color {
        switch status {
        case "예약 승인":
            return Color.billColor1
        case "예약 대기":
            return Color.billColor2
        case "학생 취소":
            return Color.billGray3
        case "예약 거절":
            return Color.billError
        default:
            return Color.clear
        }
    }
    
    func formatDate(_ inputDate: String) -> String? {
        // 입력 날짜 형식 ("yyyy-MM-dd")
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "ko_KR")
        inputFormatter.timeZone = TimeZone(abbreviation: "KST")

        // 출력 날짜 형식 ("yyyy/MM/dd(E)")
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy/MM/dd(E)"
        outputFormatter.locale = Locale(identifier: "ko_KR")
        outputFormatter.timeZone = TimeZone(abbreviation: "KST")

        // 문자열 -> Date -> 문자열 변환
        if let date = inputFormatter.date(from: inputDate) {
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
