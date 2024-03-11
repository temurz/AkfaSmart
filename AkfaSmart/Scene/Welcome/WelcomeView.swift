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
    @State private var statusBarHeight: CGFloat = 0
    private let showDealerViewTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    
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
                }
                .padding(.horizontal, 16)
            }
            .padding()
        }
    }
    
    init(viewModel: WelcomeViewModel) {
        let input = WelcomeViewModel.Input(showDealerViewTrigger: showDealerViewTrigger.asDriver())
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        
    }
}
