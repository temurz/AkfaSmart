//
//  TechnographicsView.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct TechnoGraphicsView: View {
    @ObservedObject var output: TechnoGraphicsViewModel.Output
    
    private let requestTechnoGraphicsTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    if output.technoGraphics != nil, 
                        let techno = output.technoGraphics {
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Address of factory",
                                value: "",
                                editedValue: "")
                        )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Area of factory",
                                value: ConverterToString.getArea(area: techno.area),
                                editedValue: ConverterToString.getArea(area: techno.areaEdited))
                        )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Glass factory (exists/no)",
                                value: ConverterToString.getYesOrNoString(techno.hasGlassWorkshop),
                                editedValue: ConverterToString.getYesOrNoString(techno.hasGlassWorkshopEdited))
                        )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Which series uses",
                                value: "\(getSeriesString(series: techno.workWithSeries))",
                                editedValue: "\(getSeriesString(series: techno.workWithSeries))")
                        )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Which tools uses",
                                value: "\(getSeriesString(series: techno.tools))",
                                editedValue: "\(getSeriesString(series: techno.toolsEdited))")
                        )
                    }
                    
                    
                }
                .padding(.horizontal)
            }
            
        }
        .navigationTitle("Technographics")
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
            requestTechnoGraphicsTrigger.send(())
        }
    }
    
    private func getSeriesString(series: [ModelWithIdAndName]) -> String {
        let array = series.map { $0.name ?? "" }
        return array.joined(separator: ", ")
    }
    
    init(viewModel: TechnoGraphicsViewModel) {
        let input = TechnoGraphicsViewModel.Input(requestTechnoGraphicsTrigger: requestTechnoGraphicsTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
