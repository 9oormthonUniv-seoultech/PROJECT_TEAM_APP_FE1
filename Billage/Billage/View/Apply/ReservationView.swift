//
//  ReservationView.swift
//  Billage
//
//  Created by 변상우 on 11/6/24.
//

import SwiftUI

struct ReservationView: View {
    
    var reservation: Reservation
    
    var onCancelReservation: (() -> Void)?
    var onViewRejectionReason: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(reservation.status)
                    .font(.bodybold)
                    .foregroundColor(statusFontColor(status: reservation.status))
                    .frame(width: 72, height: 36)
                    .background(statusColor(status: reservation.status))
                    .cornerRadius(12)
                
                Spacer()
            }
            .padding(.top, 15)
            .padding(.leading, 15)
            .padding(.bottom, 11)
            
            VStack(spacing: 8) {
                HStack(spacing: 10) {
                    Text(reservation.date)
                        .frame(width: 189)
                        .reservationBackgroundModifier()
                    
                    Text(reservation.numberOfPeople)
                        .frame(maxWidth: .infinity)
                        .reservationBackgroundModifier()
                }
                
                HStack(spacing: 10) {
                    Text(reservation.location)
                        .frame(width: 189)
                        .reservationBackgroundModifier()
                    
                    Text(reservation.roomNumber)
                        .frame(maxWidth: .infinity)
                        .reservationBackgroundModifier()
                }
                
                Text(reservation.time)
                    .frame(maxWidth: .infinity)
                    .reservationBackgroundModifier()
            }
            .font(.option)
            .foregroundStyle(Color.billGray1)
            .padding(.horizontal, 14)
            .padding(.bottom, 24)
            
            if reservation.status == "예약거절" {
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
                Text("문의 \(reservation.contact)")
                    .font(.sub)
                    .foregroundStyle(Color.billGray1)
                    .padding(.leading, 15)
                
                Spacer()
                
                if reservation.status != "학생취소" {
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
        case "예약승인", "예약거절", "학생취소" :
            return Color.billWh
        case "예약대기":
            return Color.billGray1
        default:
            return Color.clear
        }
    }
    
    func statusColor(status: String) -> Color {
        switch status {
        case "예약승인":
            return Color.billColor1
        case "예약대기":
            return Color.billColor2
        case "학생취소":
            return Color.billGray3
        case "예약거절":
            return Color.billError
        default:
            return Color.clear
        }
    }
}
