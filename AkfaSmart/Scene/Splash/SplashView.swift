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
    
    var body: some View {
        ZStack {
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
