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
    @Published var optionalFrom: Date? = nil
    @Published var optionalTo: Date? = nil
    @Published var isFiltered = false
}

struct DateIntervalView: View {
    @EnvironmentObject var dateFilter: DateFilter
    var navigationContoller: UINavigationController
    var body: some View {
        VStack {
            CalendarAlert(from: dateFilter.from, to: dateFilter.to)
            .environmentObject(dateFilter)
            Button(action: {
                navigationContoller.popViewController(animated: true)
            }) {
                HStack{
                    
                    Text("FILTER".localizedString)
                        .font(.headline)
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .cornerRadius(12)
                        .padding(.top, 16)
                }
            }.padding()
            Spacer()
        }
        .navigationTitle("FILTER".localizedString)
        .navigationBarItems(trailing:
                                Button(action: {
            dateFilter.optionalFrom = nil
            dateFilter.optionalTo = nil
            dateFilter.isFiltered = true
            navigationContoller.popViewController(animated: true)
        }, label: {
            Text("CLEAR".localizedString)
                .foregroundColor(Color.red)
        })
        )
    }
}
