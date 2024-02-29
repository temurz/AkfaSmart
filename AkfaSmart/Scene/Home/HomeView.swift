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
    private let getDealersTrigger = PassthroughSubject<Void,Never>()
    private let getMobileClassInfoTrigger = PassthroughSubject<Void,Never>()
    private let showAddDealerViewTrigger = PassthroughSubject<Void,Never>()
    private let showClassDetailViewTrigger = PassthroughSubject<Void,Never>()
    
    
    let cancelBag = CancelBag()
    var body: some View {
        LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            ScrollView {
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
                            showAddDealerViewTrigger.send(())
                        }
                        CustomButtonWithImage(systemImage: "bell") {
                            
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    if output.hasDealers {
                        Carousel(
                            data: $output.items,
                            isBalanceVisible: $balanceIsVisible,
                            totalOfMonth: $output.totalOfMonth,
                            totalOfYear: $output.totalOfYear,
                            openPurchases: { dealerId in
                                openPurchasesTrigger.send(dealerId)
                            },
                            openPayments: { dealerId in
                                openPaymentsTrigger.send(dealerId)
                            })
                        .frame(height: 320)
//                        .background(Color.red)
                    }else {
                        HStack {
                            Spacer()
                            Text("You didn't \n add dealers yet!")
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .font(.title2)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding()
                    }
                    Text("My class")
                        .font(.title2)
                        .padding([.horizontal, .bottom])
                    UserClassView(model: $output.mobileClass,
                                  imageData: $output.mobileClassLogoData)
                    .onTapGesture {
                        showClassDetailViewTrigger.send(())
                    }
                    .frame(height: 200)
                    Spacer()
                        .frame(height: 16)
                }
            }
        }
        .navigationTitle("")
        .onAppear {
            getDealersTrigger.send(())
            getMobileClassInfoTrigger.send(())
        }
    }
    
    init(viewModel: HomeViewModel) {
        let input = HomeViewModel.Input(
            openPurchasesTrigger: openPurchasesTrigger.asDriver(),
            openPaymentsTrigger: openPaymentsTrigger.asDriver(), calculateTotalAmounts: calculateTotalAmounts.asDriver(), getDealersTrigger: getDealersTrigger.asDriver(), getMobileClassInfo: getMobileClassInfoTrigger.asDriver(),
            showAddDealerViewTrigger: showAddDealerViewTrigger.asDriver(), showClassDetailViewTrigger: showClassDetailViewTrigger.asDriver())
        
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
