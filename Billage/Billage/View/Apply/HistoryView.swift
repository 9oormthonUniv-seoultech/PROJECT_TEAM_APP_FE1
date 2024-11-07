//
//  HistoryView.swift
//  Billage
//
//  Created by 변상우 on 11/5/24.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var overlayManager: OverlayManager
    
    let reservations = [
            Reservation(status: "예약승인", date: "2024/09/10(화)", numberOfPeople: "12 명", location: "다빈치관", roomNumber: "602호", time: "20:00 ~ 22:00", contact: "02-970-0000"),
            Reservation(status: "예약대기", date: "2024/09/12(목)", numberOfPeople: "8 명", location: "갈릴레이관", roomNumber: "203호", time: "18:00 ~ 20:00", contact: "02-970-1111"),
            Reservation(status: "예약거절", date: "2024/09/15(일)", numberOfPeople: "15 명", location: "아인슈타인관", roomNumber: "101호", time: "14:00 ~ 16:00", contact: "02-970-2222"),
            Reservation(status: "학생취소", date: "2024/09/18(수)", numberOfPeople: "10 명", location: "뉴턴관", roomNumber: "305호", time: "19:00 ~ 21:00", contact: "02-970-3333"),
            Reservation(status: "예약승인", date: "2024/09/20(금)", numberOfPeople: "20 명", location: "코페르니쿠스관", roomNumber: "501호", time: "17:00 ~ 19:00", contact: "02-970-4444")
        ]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(reservations) { reservation in
                    ReservationView(
                        reservation: reservation,
                        onCancelReservation: {
                            overlayManager.showSheet(
                                VStack(alignment: .leading) {
                                    Text("예약을 철회합니다")
                                        .font(.bodybold)
                                        .padding(.top, 35)
                                        .padding(.bottom, 16)
                                    
                                    VStack(alignment: .leading) {
                                        Text("일시   2024/09/10, 20:00 ~ 21:00")
                                            .font(.body)
                                            .foregroundStyle(Color.billGray1)
                                        
                                        Text("장소   다빈치관 602호")
                                            .font(.body)
                                            .foregroundStyle(Color.billGray1)
                                    }
                                    .padding(.bottom, 35)
                                    
                                    VStack(spacing: 8) {
                                        Button {
                                            overlayManager.hideSheet()
                                            print("철회 완료")
                                        } label: {
                                            Text("철회")
                                                .billageButtonModifier(width: .infinity, height: 44, isEnabled: true)
                                        }
                                        
                                        Button {
                                            overlayManager.hideSheet()
                                        } label: {
                                            Text("취소")
                                                .billageCancelButtonModifier(width: .infinity, height: 44)
                                        }
                                    }
                                    .padding(.bottom, 20)
                                }
                                    .padding(.horizontal, 21)
                            )
                        },
                        onViewRejectionReason: {
                            overlayManager.showSheet(
                                VStack(alignment: .leading) {
                                    Text("예약이 거절되었습니다")
                                        .font(.bodybold)
                                        .padding(.top, 35)
                                        .padding(.bottom, 16)
                                    
                                    VStack(alignment: .leading) {
                                        Text("일시   2024/09/10, 20:00 ~ 21:00")
                                            .font(.body)
                                            .foregroundStyle(Color.billGray1)
                                        
                                        Text("장소   다빈치관 602호")
                                            .font(.body)
                                            .foregroundStyle(Color.billGray1)
                                            .padding(.bottom, 10)
                                        
                                        Text("사유   학과행사 관계로 신청 불가")
                                            .font(.body)
                                            .foregroundStyle(Color.billGray1)
                                    }
                                    .padding(.bottom, 35)
                                    
                                    VStack(spacing: 8) {
                                        Button {
                                            overlayManager.hideSheet()
                                        } label: {
                                            Text("확인")
                                                .billageButtonModifier(width: .infinity, height: 44, isEnabled: true)
                                        }
                                    }
                                    .padding(.bottom, 20)
                                }
                                    .padding(.horizontal, 21)
                            )
                        }
                    )
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    HistoryView()
}
