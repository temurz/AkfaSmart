//
//  InfographicsView.swift
//  AkfaSmart
//
//  Created by Temur on 11/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct InfoItemViewModel {
    let title: String
    let value: String
    let editedValue: String
}

struct InfographicsView: View {
    @ObservedObject var output: InfographicsViewModel.Output
    
    private let requestInfographicsTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    if output.info != nil, let info = output.info {
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "FIO",
                                value: "\(info.firstName ?? "") \(info.middleName ?? "") \(info.lastName ?? "")",
                                editedValue: "\(info.firstNameEdited ?? "") \(info.middleNameEdited ?? "") \(info.lastNameEdited ?? "")")
                        )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Birth date",
                                value: "\(info.dateOfBirth ?? "")",
                                editedValue: "\(info.dateOfBirthEdited ?? "")")
                            )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Address",
                                value: "\(info.region.parentName ?? "") \(info.region.name ?? "")",
                                editedValue: "\(info.regionEdited.parentName ?? "") \(info.regionEdited.name ?? "")")
                        )
                        
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Nationality",
                                value: "\(info.nation ?? "")",
                                editedValue: "\(info.nationEdited ?? "")")
                        )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Education",
                                value: "\(info.education ?? "")",
                                editedValue: "\(info.educationEdited ?? "")")
                        )
                        
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Family",
                                value: "\((info.isMarried ?? false) ? "Married" : "Single") \((info.numberOfChildren ?? 0) != 0 ? "Has \(info.numberOfChildren!) children" : "")",
                                editedValue: "\((info.isMarriedEdited ?? false) ? "Married" : "Single") \(info.numberOfChildrenEdited != 0 ? "Has \(info.numberOfChildrenEdited) children" : "")")
                        )
                        
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "Foreign Languages",
                                value: "\(ConverterToString.getStringFrom( info.ownedLanguages))",
                                editedValue: "\(ConverterToString.getStringFrom( info.ownedLanguagesEdited))")
                        )
                        
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Infographics")
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
            requestInfographicsTrigger.send(())
        }
    }
    
    
    
    init(viewModel: InfographicsViewModel) {
        let input = InfographicsViewModel.Input(requestInfographicsTrigger: requestInfographicsTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

struct ConverterToString {
    static func getStringFrom(_ modelsWithName: [ModelWithIdAndName]) -> String {
        let array = modelsWithName.map { $0.name ?? "" }
        return array.joined(separator: ", ")
    }
    
    static func getYesOrNoString(_ bool: Bool?) -> String {
        if (bool ?? false) {
            return "Yes"
        }else {
            return "No"
        }
    }
    
    static func minMaxText(min: Double, max: Double) -> String {
        if min == 0 {
            return "eng kamida \(max)"
        }else {
            return "eng ko'pi \(min)"
        }
    }
}
