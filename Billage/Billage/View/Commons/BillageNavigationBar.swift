//
//  BillageNavigationBar.swift
//  Billage
//
//  Created by 변상우 on 11/5/24.
//

import SwiftUI

struct BillageNavigationBar: View {
    let title: String
    let dismiss: () -> Void
    
    var body: some View {
        HStack {
            ZStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 15, height: 23)
                            .foregroundColor(.billWh)
                            .padding(.leading, 20)
                    }
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    
                    Text(title)
                        .foregroundColor(.billWh)
                        .font(.head)
                        .padding(.leading, 8)
                    
                    Spacer()
                }
            }
        }
        .frame(height: 60)
        .background(Color.billageColor1)
    }
}
