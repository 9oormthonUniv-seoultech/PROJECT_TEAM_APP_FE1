//
//  View+.swift
//  Billage
//
//  Created by 변상우 on 9/21/24.
//

import Foundation
import SwiftUI

extension View {
    // MARK: - 로그인, 회원가입 텍스트필드 Modifier
    func billageTextFieldModifier(width: CGFloat, height: CGFloat) -> some View {
        modifier(BillageTextFieldModifier(width: width, height: height))
    }
    
    // MARK: - 빌리지 버튼 Modifier
    func billageButtonModifier(width: CGFloat, height: CGFloat, isEnabled: Bool) -> some View {
        modifier(BillageButtonModifier(width: width, height: height, isEnabled: isEnabled))
    }
    
    // MARK: - 빌리지 취소 버튼 Modifier
    func billageCancelButtonModifier(width: CGFloat, height: CGFloat) -> some View {
        modifier(BillageCancelButtonModifier(width: width, height: height))
    }
    
    func reservationBackgroundModifier() -> some View {
        self.modifier(ReservationBackgroundModifier())
    }
    
    func backButtonArrow() -> some View {
        self.modifier(BackButtonArrowModifier())
    }
}
