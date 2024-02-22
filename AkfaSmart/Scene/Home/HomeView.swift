//
//  HomeView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct HomeView: View {
    @ObservedObject var output: HomeViewModel.Output
    @State var balanceIsVisible = false
    @State var totalOfMonth = 0.0
    @State var totalOfYear = 0.0
    
    private let openPurchasesTrigger = PassthroughSubject<Int,Never>()
    private let openPaymentsTrigger = PassthroughSubject<Int,Never>()
    private let calculateTotalAmounts = PassthroughSubject<Void,Never>()
    
    let cancelBag = CancelBag()
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("My dilers")
                        .font(.title)
                    Spacer()
                    CustomButtonWithImage(eyeImage: output.visible ? "visibility" : "visibility_off") {
                        AuthApp.shared.visibility = !output.visible
                        balanceIsVisible.toggle()
                    }
                    .onAppear {
                        if AuthApp.shared.visibility {
                            balanceIsVisible = true
                        }
                    }
                    
                    CustomButtonWithImage(systemImage: "plus") {
                        
                    }
                    CustomButtonWithImage(systemImage: "bell") {
                        
                    }
                    
                }
                .padding(.horizontal)
                VStack(alignment: .leading) {
                    Carousel(
                        data: $output.items,
                        isBalanceVisible: $balanceIsVisible,
                        totalOfMonth: $totalOfMonth,
                        totalOfYear: $totalOfYear,
                        openPurchases: { dealerId in
                            openPurchasesTrigger.send(dealerId)
                        },
                        openPayments: { dealerId in
                            openPaymentsTrigger.send(dealerId)
                        })
                        .padding(.top)
                        
                    Text("My class")
                        .font(.title2)
                        .padding()
                    UserClassView()
                        .frame(height: 200)
                        .background(Color.yellow)
                }
            }
        }
        .navigationTitle("")
        .onAppear {
            calculateTotals()
        }
    }
    
    init(viewModel: HomeViewModel) {
        let input = HomeViewModel.Input(
            openPurchasesTrigger: openPurchasesTrigger.asDriver(),
            openPaymentsTrigger: openPaymentsTrigger.asDriver(), calculateTotalAmounts: calculateTotalAmounts.asDriver())
        
        output = viewModel.transform(input, cancelBag: cancelBag)
    }
    
    func calculateTotals() {
        totalOfMonth = output.items
            .map { $0.purchaseForMonth }
            .reduce(0,+)
        
        totalOfYear = output.items
            .map {$0.purchaseForYear}
            .reduce(0, +)
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
