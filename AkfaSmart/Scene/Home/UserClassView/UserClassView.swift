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
                        Text("Your status")
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
                Color.white
                    .frame(height: 1)
                HStack {
                    Text("For the year: ")
                        .font(.system(size: 15))
                        .foregroundColor(Color(hex: "#858890"))
                    Text("2000 kg")
                        .font(.system(size: 20))
                        .foregroundColor(Color(hex: "#858890"))
                    Spacer()
                }
                .padding()
            }
            .background(Color(hex: model?.backgroundColor ?? ""))
            
            HStack {
                Text("Detail")
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
