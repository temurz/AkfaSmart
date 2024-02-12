//
//  SplashView.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct SplashView: View {
    let output: SplashViewModel.Output
    private let loadViewsTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    @State var statusBarHeight: CGFloat = 0
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea(edges: .top)
            Color.white
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .padding(.top, statusBarHeight > 0 ? statusBarHeight : 48)
                .ignoresSafeArea()
                .onAppear {
                    if let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager {
                        statusBarHeight = statusBarManager.statusBarFrame.height
                    }
                }
            
            
            VStack {
                Group {
                    Image("akfa_smart")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .scaledToFit()
                        .padding(.horizontal, 32)
                }.padding(.horizontal)
                
            }
            .padding()
        }
        .onAppear {
            loadViewsTrigger.send(())
        }
    }
    
    init(viewModel: SplashViewModel) {
        let input = SplashViewModel.Input(loadViewsTrigger: loadViewsTrigger.asDriver())
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
