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
                VStack {
                    if output.hrGraphics != nil, let hrGraphics = output.hrGraphics {
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Number of employees",
                                value: "\(hrGraphics.numberOfEmployees ?? 0) \r\n\(hrGraphics.aboutEmployees ?? "")",
                                editedValue: "\(hrGraphics.numberOfEmployeesEdited)")
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
        .onAppear {
            requestHRGraphicsTrigger.send(())
        }
    }
    
    init(viewModel: HRgraphicsViewModel) {
        let input = HRgraphicsViewModel.Input(requestHRGraphicsTrigger: requestHRGraphicsTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
