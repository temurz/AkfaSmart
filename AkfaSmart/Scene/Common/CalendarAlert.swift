//
//  CalendarAlert.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import SwiftUIRefresh
import Foundation

struct CalendarAlert: View {
    @State var from: Date
    @State var to: Date
    @State var fromCalendarId: UUID = UUID()
    @State var toCalendarId: UUID = UUID()
    @State var isFromDatePickerVisible = false
    @State var isToDatePickerVisible = false
    @EnvironmentObject var dateFilter: DateFilter
    
    var body: some View {
        VStack(alignment: .trailing){
//            DatePicker("DATE_OF_START".localizedString, selection: $from, in: ...Date(), displayedComponents: .date)
//                .environment(\.locale, Locale.init(identifier: "de_DE"))
////                .environment(\.locale, Locale.init(identifier: "en"))
//                .id(fromCalendarId)
//                .onChange(of: from, perform: { newValue in
//                    fromCalendarId = UUID()
//                    dateFilter.optionalFrom = from
//                    dateFilter.optionalTo = to
//                    dateFilter.from = from
//                    dateFilter.to = to
//                    dateFilter.isFiltered = true
//                })
//                
//                .padding()
            
            HStack {
                Text("DATE_OF_START".localizedString)
                Spacer()
                Text(selectedFromDateString.wrappedValue)
                                .padding(8)
                                .onTapGesture {
                                    self.isFromDatePickerVisible.toggle()
                                }
                                .background(Color(hex: "#F5F7FA"))
                                .cornerRadius(8)
            }
            .padding()
            
                        
            if isFromDatePickerVisible {
                DatePicker("", selection: $from, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .environment(\.locale, Locale(identifier: AuthApp.shared.language))
                    .labelsHidden()
                    .id(fromCalendarId)
                    .onChange(of: from, perform: { newValue in
                        fromCalendarId = UUID()
                        dateFilter.optionalFrom = from
                        dateFilter.optionalTo = to
                        dateFilter.from = from
                        dateFilter.to = to
                        dateFilter.isFiltered = true
                        self.isFromDatePickerVisible = false
                    })
                    .clipped()
                    .background(Color.clear)
            }
            
//            DatePicker("DATE_OF_END".localizedString, selection: $to, in: ...Date(),displayedComponents: .date)
//                .environment(\.locale, Locale.init(identifier: "de_DE"))
//                .id(toCalendarId)
//                .onChange(of: to, perform: { newValue in
//                    toCalendarId = UUID()
//                    dateFilter.optionalFrom = from
//                    dateFilter.optionalTo = to
//                    dateFilter.from = from
//                    dateFilter.to = to
//                    dateFilter.isFiltered = true
//                })
//                .padding()
            
            HStack {
                Text("DATE_OF_END".localizedString)
                Spacer()
                Text(selectedToDateString.wrappedValue)
                                .padding(8)
                                .onTapGesture {
                                    self.isToDatePickerVisible.toggle()
                                }
                                .background(Color(hex: "#F5F7FA"))
                                .cornerRadius(8)
            }
            .padding()
            
                        
            if isToDatePickerVisible {
                DatePicker("", selection: $to, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .environment(\.locale, Locale(identifier: AuthApp.shared.language))
                    .labelsHidden()
                    .id(toCalendarId)
                    .onChange(of: to, perform: { newValue in
                        toCalendarId = UUID()
                        dateFilter.optionalFrom = from
                        dateFilter.optionalTo = to
                        dateFilter.from = from
                        dateFilter.to = to
                        dateFilter.isFiltered = true
                        self.isToDatePickerVisible = false
                    })
                    .clipped()
                    .background(Color.clear)
            }
        }
        .padding([.horizontal],10)
    }
    
    private var selectedFromDateString: Binding<String> {
        Binding<String>(
            get: {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"
                return formatter.string(from: self.from)
            },
            set: { newDateString in
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"
                if let newDate = formatter.date(from: newDateString) {
                    self.from = newDate
                }
            }
        )
    }
    
    private var selectedToDateString: Binding<String> {
        Binding<String>(
            get: {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"
                return formatter.string(from: self.to)
            },
            set: { newDateString in
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"
                if let newDate = formatter.date(from: newDateString) {
                    self.to = newDate
                }
            }
        )
    }
}
