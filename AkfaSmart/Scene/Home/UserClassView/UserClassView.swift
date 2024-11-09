//
//  UserClassView.swift
//  AkfaSmart
//
//  Created by Temur on 22/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct UserClassView: View {
    @Binding var model: MobileClass?
    @Binding var imageData: Data?
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                HStack {
                    Image(data: imageData ?? Data())?
                        .resizable()
                        .frame(width: 54, height: 54)
                    Text(model?.klassGroupName ?? "")
                        .font(.italic(.title)())
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                }
                .padding()
            }
            .background(model?.backgroundColor != nil ? Color(hex: model?.backgroundColor ?? "") : Color.white)
        }
        .cornerRadius(12)
    }
}
