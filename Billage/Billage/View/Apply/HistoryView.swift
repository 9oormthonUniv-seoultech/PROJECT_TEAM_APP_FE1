//
//  HistoryView.swift
//  Billage
//
//  Created by 변상우 on 11/5/24.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var overlayManager: OverlayManager
    @EnvironmentObject var reservationStore: ReservationStore
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(reservationStore.totalReservationList, id: \.self) { reservation in
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
