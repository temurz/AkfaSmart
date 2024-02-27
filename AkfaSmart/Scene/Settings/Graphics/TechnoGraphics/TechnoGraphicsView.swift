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
                                value: "\(techno.area ?? 0) sq.m.",
                                editedValue: "\(techno.areaEdited) sq.m.")
                        )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Glass factory (exists/no)",
                                value: "\((techno.hasGlassWorkshop ?? false) ? "Yes" : "No")",
                                editedValue: "\(techno.hasGlassWorkshopEdited ? "Yes" : "No")")
                        )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Which series uses",
                                value: "Uses \(getSeriesString(series: techno.workWithSeries))",
                                editedValue: "Uses \(getSeriesString(series: techno.workWithSeries))")
                        )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Which tools uses",
                                value: "Uses \(getSeriesString(series: techno.tools))",
                                editedValue: "Uses \(getSeriesString(series: techno.toolsEdited))")
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
        .onAppear {
            requestTechnoGraphicsTrigger.send(())
        }
    }
    
    private func getSeriesString(series: [ModelWithIdAndName]) -> String {
        var array = series.map { $0.name ?? "" }
        return array.joined(separator: ", ")
    }
    
    init(viewModel: TechnoGraphicsViewModel) {
        let input = TechnoGraphicsViewModel.Input(requestTechnoGraphicsTrigger: requestTechnoGraphicsTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
