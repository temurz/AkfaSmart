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
    let action: (_ from: Date, _ to: Date) -> Void
    
    var body: some View {
        VStack(alignment: .trailing){
            DatePicker("DATE_OF_START".localizedString, selection: $from, in: ...Date(), displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: AuthApp.shared.language))
                .id(fromCalendarId)
                .onChange(of: from, perform: { newValue in
                    fromCalendarId = UUID()
                })
                
                .padding()
            
            DatePicker("DATE_OF_END".localizedString, selection: $to, in: ...Date(),displayedComponents: .date)
                .environment(\.locale, Locale.init(identifier: AuthApp.shared.language))
                .id(toCalendarId)
                .onChange(of: to, perform: { newValue in
                    toCalendarId = UUID()
                })
                .padding()
            
            
            Button(action: {
                self.action(from,to)
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
           
        }
        .padding([.horizontal],10)
    }
}
