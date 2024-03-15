//
//  HRGraphicsEditView.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct HRGraphicsEditView: View {
    @ObservedObject var output: HRGraphicsEditViewModel.Output
    private let saveHRGraphicsTrigger = PassthroughSubject<HRGraphics, Never>()
    private let loadInitialValuesTrigger = PassthroughSubject<HRGraphics,Never>()
    private let cancelBag = CancelBag()
    
    private let model: HRGraphics
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            ScrollView {
                VStack {
                    EditInfographicsViewRow(title: "NUMBER_OF_EMPLOYEES".localizedString, constantModel: "\(model.numberOfEmployees ?? 0)", editedValue: $output.numberOfEmployeesEditedString, keyboardType: .numberPad)
                    EditViewRowWithMultiLine(title: "ABOUT_EMPLOYEES".localizedString, constantModel: model.aboutEmployees, editedValue: $output.aboutEmployeesEdited)
                    sellerRow
                    accountantRow
                    
                }
            }
        }
        .navigationTitle("HR_GRAPHICS_TITLE".localizedString)
        .navigationBarItems(trailing:
                                Button(action: {
            saveHRGraphicsTrigger.send(model)
        }, label: {
            Text("SAVE".localizedString)
                .bold()
                .foregroundColor(Color.red)
        })
        )
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            loadInitialValuesTrigger.send(model)
        }
        
        
    }
    
    var sellerRow: some View {
        VStack(alignment: .leading) {
            Text("IS_THERE_A_SELLER".localizedString)
                .font(.headline)
                .padding(.horizontal, 4)
            Text(ConverterToString.getYesOrNoString(model.hasSeller))
                .font(.subheadline)
                .padding(.horizontal, 4)
            ZStack(alignment: .leading) {
                Color(hex: "#F5F7FA")
                    .foregroundStyle(.red)
                    .frame(height: 48)
                    .cornerRadius(12)
                HStack {
                    Menu {
                        Button {
                            output.hasSellerEdited = true
                        } label: {
                            Text("YES".localizedString)
                        }
                        Button {
                            output.hasSellerEdited = false
                        } label: {
                            Text("NO".localizedString)
                        }

                    } label: {
                        HStack {
                            if let hasSeller = output.hasSellerEdited {
                                Text( hasSeller ? "YES".localizedString : "NO".localizedString)
                                    .foregroundStyle(.red)
                                    .padding(.horizontal)
                            }else {
                                Text("IS_THERE_A_SELLER".localizedString)
                                    .foregroundStyle(.gray)
                                    .padding(.horizontal)
                            }
                            Spacer()
                        }
                    }
                }
            }
        }.padding(.horizontal)
    }
    
    var accountantRow: some View {
        VStack(alignment: .leading) {
            Text("IS_THERE_AN_ACCOUNTANT".localizedString)
                .font(.headline)
                .padding(.horizontal, 4)
            Text(ConverterToString.getYesOrNoString(model.hasAccountant))
                .font(.subheadline)
                .padding(.horizontal, 4)
            ZStack(alignment: .leading) {
                Color(hex: "#F5F7FA")
                    .foregroundStyle(.red)
                    .frame(height: 48)
                    .cornerRadius(12)
                HStack {
                    Menu {
                        Button {
                            output.hasAccountantEdited = true
                        } label: {
                            Text("YES".localizedString)
                        }
                        Button {
                            output.hasAccountantEdited = false
                        } label: {
                            Text("NO".localizedString)
                        }

                    } label: {
                        HStack {
                            if let hasAccountant = output.hasAccountantEdited {
                                Text( hasAccountant ? "YES".localizedString : "NO".localizedString)
                                    .foregroundStyle(.red)
                                    .padding(.horizontal)
                            }else {
                                Text("IS_THERE_AN_ACCOUNTANT".localizedString)
                                    .foregroundStyle(.gray)
                                    .padding(.horizontal)
                            }
                            Spacer()
                        }
                    }
                }
            }
        }.padding(.horizontal)
        
    }
    
    init(viewModel: HRGraphicsEditViewModel, model: HRGraphics) {
        self.model = model
        
        let input = HRGraphicsEditViewModel.Input(
            saveHRGraphicsTrigger: saveHRGraphicsTrigger.asDriver(),
            loadInitialValuesTrigger: loadInitialValuesTrigger.asDriver()
        )
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
