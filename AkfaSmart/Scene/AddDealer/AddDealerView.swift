//
//  AddDealerView.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Combine
import SwiftUI
struct AddDealerView: View {
    @ObservedObject var output: AddDealerViewModel.Output
    let addDealerTrigger = PassthroughSubject<Void,Never>()
    let showQRScannerTrigger = PassthroughSubject<Bool,Never>()
    let showMainView = PassthroughSubject<Void, Never>()
    
    private let cancelBag = CancelBag()
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("ADD_MY_DEALER".localizedString)
                    .font(.title)
                
                Text("CAN_ADD_DEALER_BY_SCAN".localizedString)
                    .font(.system(size: 15))
                    .foregroundColor(Color(hex: "#9497A1"))
                HStack {
                    TextField("CODE".localizedString, text: $output.qrCodeValue)
                        .padding(.trailing, 32)
                        .padding(.leading, 16)
                    Spacer()
                    ZStack {
                        Image("center_focus")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding()
                            .onTapGesture {
                                showQRScannerTrigger.send(true)
                            }
                    }
                    
                }
                .background(Color(hex: "#F5F7FA"))
                .cornerRadius(12)
                .padding(.vertical)
                
//                Text("PHONE_NUMBER".localizedString)
//                    .font(.system(size: 15))
//                    .foregroundColor(Color(hex: "#9497A1"))
//                Text(AuthApp.shared.username?.formatToUzNumber() ?? "")
//                    .font(.headline)
                
                Spacer()
                
                Button() {
                    addDealerTrigger.send(())
                } label: {
                    Text("CONFIRM".localizedString)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .disabled(!self.output.isConfirmEnabled)
                        .cornerRadius(12)
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
            .padding()
        }
        .padding()
        .sheet(isPresented: $output.isShowingQrScanner) {
            QRCodeScannerViewMain(result: $output.qrCodeValue)
        }
    }
    
    init(viewModel: AddDealerViewModel) {
        let input = AddDealerViewModel.Input(addDealerTrigger: addDealerTrigger.asDriver(), showQRScannerTrigger: showQRScannerTrigger.asDriver(),
                                             showMainView: showMainView.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
