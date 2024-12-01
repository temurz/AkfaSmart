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
            Image("red_transparent_icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width)
            VStack {
                Group {
                    Image("akfa_smart_new")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .scaledToFit()
                        .background(Color.clear)
                        .padding(.horizontal, 32)
                }.padding(.horizontal)
                
            }
            .padding()
            .background(.clear)
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
