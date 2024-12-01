//
//  SingleCodeView.swift
//  AkfaSmart
//
//  Created by Temur on 20/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
struct SingleCodeView: View {
    @Binding var filled: Bool
    var body: some View {
        VStack {
            if filled {
                Color.red
                    .frame(width: 24, height: 24)
                    .cornerRadius(12)
            }else {
                Color.clear
                    .frame(width: 24, height: 24)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(filled ? .red : Color(hex: "#9DA8C2"), lineWidth: 1)
                    }
            }
        }
//        .frame(width: 40, height: 60)
//        .overlay {
//            RoundedRectangle(cornerRadius: 6)
//                .stroke(filled ? .red : Color(hex: "#9DA8C2"), lineWidth: 1)
//        }
    }
}
