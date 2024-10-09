//
//  WelcomeView.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct WelcomeView: View {
    let output: WelcomeViewModel.Output
    private let showDealerViewTrigger = PassthroughSubject<Void,Never>()
    private let showMainView = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Spacer()
                    Image("akfa_smart")
                        .frame(width: 124, height: 44)
                    Spacer()
                }
                .ignoresSafeArea()
                Group {
                    HStack {
                        Image("welcome")
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .scaledToFill()
                            .padding(.vertical)
                    }
                    .padding(.top)
                    
                    Spacer()
                    Text("WELCOME".localizedString)
                        .font(.system(size: 32))
                        .lineLimit(2)
                    Button() {
                        showDealerViewTrigger.send(())
                    } label: {
                        HStack {
                            Image("add_link")
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("ADD_MY_DEALER".localizedString)
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .cornerRadius(12)
                        .padding(.top, 16)
                    }
                    Button() {
                        showMainView.send(())
                    } label: {
                        Text("SKIP".localizedString)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .foregroundColor(Color.blue)
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding()
        }
    }
    
    init(viewModel: WelcomeViewModel) {
        let input = WelcomeViewModel.Input(
            showDealerViewTrigger: showDealerViewTrigger.asDriver(),
            showMainView: showMainView.asDriver())
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        
    }
}
