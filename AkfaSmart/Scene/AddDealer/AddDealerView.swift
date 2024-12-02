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
    let addDealerTrigger = PassthroughSubject<AddDealer,Never>()
    let searchDealerTrigger = PassthroughSubject<Void,Never>()
    let showQRScannerTrigger = PassthroughSubject<Bool,Never>()
    let showMainView = PassthroughSubject<Void, Never>()
    let dismissTrigger = PassthroughSubject<Void, Never>()
    
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                ZStack {
                    HStack {
                        Spacer()
                        Text("ADD_MY_DEALER".localizedString)
                            .font(.headline)
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button {
                            dismissTrigger.send(())
                        } label: {
                            Image("cancel")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                        }
                        .padding(.vertical)

                    }
                }
                VStack(alignment: .leading, spacing: 8) {
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
                    
                    HStack {
                        Spacer()
                        Button {
                            searchDealerTrigger.send(())
                        } label: {
                            Text("SEARCH".localizedString)
                                .padding()
                                .foregroundStyle(.white)
                                .background(output.qrCodeValue.isEmpty ? .gray : .red)
                                .cornerRadius(12)
                        }
                        .allowsHitTesting(!output.qrCodeValue.isEmpty)
                        Spacer()
                    }
                    
                    if let dealer = output.addDealer {
                        Text("FIO".localizedString)
                            .font(.system(size: 15))
                            .foregroundStyle(Color(hex: "#9497A1"))
                        Text(dealer.printableName ?? "")
                            .font(.headline)
                        Text("PHONE_NUMBER".localizedString)
                            .font(.system(size: 15))
                            .foregroundColor(Color(hex: "#9497A1"))
                        Text(dealer.phone ?? "")
                            .font(.headline)
                    }
                    
                    Spacer()
                    
                    Button() {
                        if let dealer = output.addDealer {
                            addDealerTrigger.send(dealer)
                        }
                    } label: {
                        Text("CONFIRM".localizedString)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .foregroundColor(Color.white)
                            .background(output.isConfirmEnabled ? .red : .gray)
                            .disabled(self.output.isConfirmEnabled)
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
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding(.horizontal)
            .padding(.bottom)
            .alert(isPresented: $output.alert.isShowing) {
                Alert(
                    title: Text(output.alert.title),
                    message: Text(output.alert.message),
                    dismissButton: .default(Text("OK"))
                )
            }
            .fullScreenCover(isPresented: $output.isShowingQrScanner) {
                QRCodeScannerViewMain(result: $output.qrCodeValue)
                    .onDisappear {
                        if !output.qrCodeValue.isEmpty {
                            searchDealerTrigger.send(())
                        }
                    }
            }

        }
    }
    
    init(viewModel: AddDealerViewModel) {
        let input = AddDealerViewModel.Input(
            addDealerTrigger: addDealerTrigger.asDriver(),
            searchDealerTrigger: searchDealerTrigger.asDriver(),
            showQRScannerTrigger: showQRScannerTrigger.asDriver(),
            showMainView: showMainView.asDriver(),
            dismissTrigger: dismissTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
