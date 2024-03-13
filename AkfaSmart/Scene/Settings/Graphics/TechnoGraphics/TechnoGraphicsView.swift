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
    private let showEditTechnoGraphicsViewTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    if output.technoGraphics != nil, 
                        let techno = output.technoGraphics {
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "ADDRESS_OF_FACTORY".localizedString,
                                value: "",
                                editedValue: "")
                        )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "AREA_OF_FACTORY".localizedString,
                                value: ConverterToString.getArea(area: techno.area),
                                editedValue: ConverterToString.getArea(area: techno.areaEdited))
                        )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "GLASS_FACTORY_EXISTS".localizedString,
                                value: ConverterToString.getYesOrNoString(techno.hasGlassWorkshop),
                                editedValue: ConverterToString.getYesOrNoString(techno.hasGlassWorkshopEdited))
                        )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "WHICH_SERIES_USES".localizedString,
                                value: "\(getSeriesString(series: techno.workWithSeries))",
                                editedValue: "\(getSeriesString(series: techno.workWithSeries))")
                        )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "WHICH_TOOLS_USES".localizedString,
                                value: "\(getSeriesString(series: techno.tools))",
                                editedValue: "\(getSeriesString(series: techno.toolsEdited))")
                        )
                    }
                }
                .padding(.horizontal)
            }
            
        }
        .navigationTitle("TECHNOGRAPHICS_TITLE".localizedString)
        .alert(isPresented: $output.alert.isShowing) {
            Alert(title: Text(output.alert.title),
                  message: Text(output.alert.message),
                  dismissButton: .default(Text("OK")))
        }
        .navigationBarItems(trailing: Button(action: {
            
        }, label: {
            Text("EDIT".localizedString)
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
        let input = TechnoGraphicsViewModel.Input(
            requestTechnoGraphicsTrigger: requestTechnoGraphicsTrigger.asDriver(),
            showEditTechnoGraphicsViewTrigger: showEditTechnoGraphicsViewTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
