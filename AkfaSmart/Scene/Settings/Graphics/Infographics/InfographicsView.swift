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
                                title: "FIO".localizedString,
                                value: ConverterToString.createFullName(from: [info.firstName, info.middleName, info.lastName]),
                                editedValue: ConverterToString.createFullName(from: [info.firstNameEdited, info.middleNameEdited, info.lastNameEdited], isEdited: true))
                            )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "DATE_OF_BIRTH".localizedString,
                                value: "\(info.dateOfBirth ?? "")",
                                editedValue: "\(info.dateOfBirthEdited ?? "")")
                            )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "ADDRESS".localizedString,
                                value: ConverterToString.createFullName(from: [info.region.parentName, info.region.name]),
                                editedValue: ConverterToString.createFullName(from: [info.regionEdited.parentName, info.regionEdited.name], isEdited: true))
                        )
                        
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "NATIONALITY".localizedString,
                                value: "\(info.nation ?? "")",
                                editedValue: "\(info.nationEdited ?? "")")
                        )
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "EDUCATION".localizedString,
                                value: "\(info.education ?? "")",
                                editedValue: "\(info.educationEdited ?? "")")
                        )
                        
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "FAMILY".localizedString,
                                value: "\(ConverterToString.getMarriedStatus(bool: info.isMarried)) \((info.numberOfChildren ?? 0) != 0 ? "HAS".localizedString + "\(info.numberOfChildren!)" + "CHILDREN_EN".localizedString : "")",
                                editedValue: "\(ConverterToString.getMarriedStatus(bool: info.isMarried, isEdited: true)) \((info.numberOfChildrenEdited ?? 0) != 0 ? "HAS".localizedString + "\(info.numberOfChildrenEdited ?? 0)" + "CHILDREN_EN".localizedString : "")")
                        )
                        
                        InfoViewRow(
                            viewModel: InfoItemViewModel(
                                title: "FOREIGN_LANGUAGES".localizedString,
                                value: "\(ConverterToString.getStringFrom( info.ownedLanguages))",
                                editedValue: "\(ConverterToString.getStringFrom( info.ownedLanguagesEdited, isEdited: true))")
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("INFOGRAPHICS".localizedString)
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
            requestInfographicsTrigger.send(())
        }
    }
    
    
    
    init(viewModel: InfographicsViewModel) {
        let input = InfographicsViewModel.Input(requestInfographicsTrigger: requestInfographicsTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

