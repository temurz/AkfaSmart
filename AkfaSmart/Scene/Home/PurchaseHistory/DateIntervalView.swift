//
//  DateIntervalView.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import UIKit
class DateFilter: ObservableObject {
    @Published var from: Date = (Calendar.current.date(byAdding: .year, value: -20, to: Date()) ?? Date(timeIntervalSince1970: 0))
    @Published var to: Date = Date()
}

struct DateIntervalView: View {
    @EnvironmentObject var dateFilter: DateFilter
    var navigationContoller: UINavigationController
    var body: some View {
        VStack {
            CalendarAlert(from: dateFilter.from, to: dateFilter.to) { from, to in
                dateFilter.from = from
                dateFilter.to = to
                navigationContoller.popViewController(animated: true)
            }
            Spacer()
        }
        .navigationTitle("Filter")
    }
}
