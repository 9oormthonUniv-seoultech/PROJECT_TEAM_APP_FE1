//
//  BillageDatePickerScrollView.swift
//  Billage
//
//  Created by 변상우 on 10/8/24.
//

import SwiftUI

struct BillageDatePickerScrollView: View {
    
    // 부모 뷰에서 바인딩으로 받아올 선택된 날짜
    @Binding var selectedDate: Date
    
    // 오늘 날짜를 기준으로 날짜들을 생성하는 함수
    func generateDates(startingFrom date: Date, count: Int) -> [Date] {
        var dates = [Date]()
        let calendar = Calendar.current
        for i in 0..<count {
            if let nextDate = calendar.date(byAdding: .day, value: i, to: date) {
                dates.append(nextDate)
            }
        }
        return dates
    }

    // 날짜 포맷 설정
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월d일"
        return formatter
    }()

    let dayOfWeekFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR") // 한국어 설정
        formatter.dateFormat = "EEEE" // 요일 출력
        return formatter
    }()

    var body: some View {
        let today = Date() // 오늘 날짜 기준
        let dates = generateDates(startingFrom: today, count: 30) // 30일치 날짜 생성

        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 30) {
                ForEach(dates, id: \.self) { date in
                    VStack {
                        Text(dateFormatter.string(from: date)) // "9월10일" 형식
                            .font(.sub)
                            .foregroundColor(isSameDay(date1: selectedDate, date2: date) ? .billColor1 : .billageGray1) // 선택된 날짜 텍스트 색상 변경


                        Text(dayOfWeekFormatter.string(from: date)) // "화요일" 형식
                            .font(.par)
                            .foregroundColor(isSameDay(date1: selectedDate, date2: date) ? .billColor1 : .billageGray1) // 선택된 날짜 텍스트 색상 변경
                    }
                    .background(selectedDate == date ? Color(.systemGray5) : Color.clear) // 선택된 날짜 배경 변경
                    .cornerRadius(8)
                    .onTapGesture {
                        selectedDate = date // 날짜 선택 시 업데이트
                    }
                }
            }
            
//            .background(.whg)
            .padding()
        }
    }
    
    // 두 날짜가 같은 날인지 비교하는 함수
    func isSameDay(date1: Date?, date2: Date) -> Bool {
        guard let date1 = date1 else { return false }
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}
