//
//  Modifiers.swift
//  Billage
//
//  Created by 변상우 on 9/23/24.
//

import SwiftUI
import Foundation

// MARK: - 로그인, 회원가입 텍스트필드 Modifier
struct BillageTextFieldModifier: ViewModifier {
    
    var width: CGFloat
    var height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.body)
            .padding()
            .textInputAutocapitalization(.never) // 처음 문자 자동으로 대문자로 바꿔주는 기능 막기
            .frame(width: width, height: height)
            .overlay(
                RoundedRectangle(cornerRadius: 8) // 둥근 모서리 추가
                    .stroke(Color.billGray3, lineWidth: 1.5) // 테두리 색과 두께 설정
            )
            .cornerRadius(8) // 모서리 반경 설정
    }
}

// MARK: - 중복 확인 버튼 Modifier
struct BillageButtonModifier: ViewModifier {
    
    var width: CGFloat
    var height: CGFloat
    var isEnabled: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: width, height: height)
                .tint(isEnabled ? .billColor1 : .billGray3)
            content
                .font(.bodybold)
                .foregroundColor(.white)
        }
    }
}

struct BackButtonArrowModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss

    func body(content: Content) -> some View {
        content.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .font(.title2)
                        .foregroundColor(Color.billGray3)
                }
            }
        }
    }
}
