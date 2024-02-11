//
//  HomeView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    let output: HomeViewModel.Output
    
    let cancelBag = CancelBag()
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("My dilers")
                        .font(.title)
                    Spacer()
                    CustomButtonWithImage(eyeImage: output.visible ? "visibility" : "visibility_off") {
                        AuthApp.shared.visibility = !output.visible
                    }
                    
                    CustomButtonWithImage(systemImage: "plus") {
                        
                    }
                    CustomButtonWithImage(systemImage: "bell") {
                        
                    }
                    
                }
            }
            .padding()
        }
        .navigationTitle("")
    }
    
    init(viewModel: HomeViewModel) {
        let input = HomeViewModel.Input()
        output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

#Preview {
    HomeView(viewModel: PreviewAssembler().resolve(navigationController: UINavigationController()))
}

struct CustomButtonWithImage: View {
    let systemImage: String
    var action: () -> Void
    @State var eyeImage: String
    var body: some View {
        Button {
            action()
            if systemImage.isEmpty {
                toggle()
            }
        } label: {
            Group {
                if systemImage.isEmpty {
                    Image(eyeImage)
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                }else {
                    Image(systemName: systemImage)
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                }
            }
            
        }
        .frame(width: 40, height: 32)
        .background(Color.red)
        .cornerRadius(12)
    }
    
    private func toggle() {
        if eyeImage == "visibility" {
            eyeImage = "visibility_off"
            
        }else {
            eyeImage = "visibility"
        }
    }
    
    init(eyeImage: String = "", systemImage: String = "", action: @escaping () -> Void) {
        self.eyeImage = eyeImage
        self.systemImage = systemImage
        self.action = action
    }
}
