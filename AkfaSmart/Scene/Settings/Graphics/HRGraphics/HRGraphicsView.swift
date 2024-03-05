//
//  HRgraphicsView.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//


import SwiftUI
import Combine
struct HRItemViewModel {
    let title: String
    let value: String
}

struct HRgraphicsView: View {
    @ObservedObject var output: HRgraphicsViewModel.Output
    
    private let requestHRGraphicsTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    if output.hrGraphics != nil, let hrGraphics = output.hrGraphics {
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Number of employees",
                                value: ConverterToString.getAmount(from: hrGraphics.numberOfEmployees),
                                editedValue: ConverterToString.getAmount(from: hrGraphics.numberOfEmployeesEdited)
                            )
                        )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "About employees",
                                value: "\(hrGraphics.aboutEmployees ?? "")",
                                editedValue: "\(hrGraphics.aboutEmployeesEdited ?? "")"
                            )
                        )
                        
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Is there a seller",
                                value: "\(ConverterToString.getYesOrNoString(hrGraphics.hasSeller))",
                                editedValue: "\(ConverterToString.getYesOrNoString(hrGraphics.hasSellerEdited))"
                            )
                        )
                        
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Is there an accountant",
                                value: "\(ConverterToString.getYesOrNoString(hrGraphics.hasAccountant))",
                                editedValue: "\(ConverterToString.getYesOrNoString(hrGraphics.hasAccountantEdited))"
                            )
                        )
                    }
                }
                .padding()
            }
        }
        .navigationTitle("HR graphics")
        .alert(isPresented: $output.alert.isShowing) {
            Alert(title: Text(output.alert.title),
                  message: Text(output.alert.message),
                  dismissButton: .default(Text("OK")))
        }
        .navigationBarItems(trailing: Button(action: {
            
        }, label: {
            Text("Edit")
                .foregroundColor(.red)
                .font(.headline)
        }))
        .onAppear {
            requestHRGraphicsTrigger.send(())
        }
    }
    
    init(viewModel: HRgraphicsViewModel) {
        let input = HRgraphicsViewModel.Input(requestHRGraphicsTrigger: requestHRGraphicsTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
