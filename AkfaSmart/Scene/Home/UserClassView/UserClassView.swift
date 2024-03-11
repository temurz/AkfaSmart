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
                    VStack(alignment: .leading) {
                        Text(model?.klassGroupName ?? "")
                            .font(.italic(.title)())
                        Text(model?.klassName ?? "")
                            .font(.italic(.subheadline)())
                    }
                    VStack {
                        Text("YOUR_STATUS")
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                            .padding(4)
                            .background(Color(hex: "#AFB2BA"))
                            .cornerRadius(12)
                        Spacer()
                    }
                    Spacer()
                    Image(data: imageData ?? Data())?
                        .resizable()
                        .frame(width: 54, height: 54)
                }
                .padding()
            }
            .background(model?.backgroundColor != nil ? Color(hex: model?.backgroundColor ?? "") : Color.white)
            
            HStack {
                Text("DETAIL")
                    .padding()
                Spacer()
                Image("arrow_forward")
                    .resizable()
                    .foregroundColor(.red)
                    .frame(width: 24, height: 24)
                    .padding()
            }
            .background(Color.white)
        }
        .cornerRadius(12)
        .padding()
        .shadow(radius: 4)
    }
}
