//
//  EditInfographicsView.swift
//  AkfaSmart
//
//  Created by Temur on 12/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct EditInfographicsView: View {
    @ObservedObject var output: EditInfographicsViewModel.Output
    private let loadLanguagesTrigger = PassthroughSubject<Void,Never>()
    private let loadRegionsTrigger = PassthroughSubject<Void,Never>()
    private let loadChildRegionsTrigger = PassthroughSubject<Int,Never>()
    private let saveInfographicsTrigger = PassthroughSubject<Infographics, Never>()
    private let popViewControllerTrigger = PassthroughSubject<Void, Never>()
    
    private let loadInitialValuesTrigger = PassthroughSubject<Infographics,Never>()
    private let cancelBag = CancelBag()
    
    @State var showChildRegions = false
    
    private let model: Infographics
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack(alignment: .leading) {
                CustomNavigationBar(title: "INFOGRAPHICS".localizedString, rightBarTitle: "SAVE".localizedString) {
                    popViewControllerTrigger.send(())
                } onRightBarButtonTapAction: {
                    saveInfographicsTrigger.send(model)
                }
                ScrollView {
                    VStack(spacing: 4) {
                        EditInfographicsViewRow(title: "FIRST_NAME".localizedString, constantModel: model.firstName, editedValue: $output.firstName)
                        EditInfographicsViewRow(title: "MIDDLE_NAME".localizedString, constantModel: model.middleName, editedValue: $output.middleName)
                        EditInfographicsViewRow(title: "LAST_NAME".localizedString, constantModel: model.lastName, editedValue: $output.lastName)
                        marriedRow
                        childRow
                        dateRow
                        regionRow
                        EditInfographicsViewRow(title: "ADDRESS".localizedString, constantModel: model.address, editedValue: $output.address)
                        EditInfographicsViewRow(title: "NATIONALITY".localizedString, constantModel: model.nation, editedValue: $output.nation)
                        EditInfographicsViewRow(title: "EDUCATION".localizedString, constantModel: model.education, editedValue: $output.educationEdited)
                        languagesRow
                    }
                    .onChange(of: output.initialValuesAreLoaded, perform: { value in
                        
                    })
                }
            }
            .alert(isPresented: $output.alert.isShowing) {
                Alert(
                    title: Text(output.alert.title),
                    message: Text(output.alert.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .onAppear {
            loadInitialValuesTrigger.send(model)
            loadRegionsTrigger.send(())
            loadLanguagesTrigger.send(())
        }
    }
    
    var marriedRow: some View {
        VStack(alignment: .leading) {
            Text("IS_MARRIED".localizedString)
                .font(.headline)
                .padding(.horizontal, 4)
            Text(ConverterToString.getYesOrNoString(model.isMarried))
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
                            output.isMarriedEdited = true
                        } label: {
                            Text("YES".localizedString)
                        }
                        Button {
                            output.isMarriedEdited = false
                        } label: {
                            Text("NO".localizedString)
                        }
                    } label: {
                        HStack {
                            if model.isMarriedEdited == nil {
                                Text("NO_INFORMATION".localizedString)
                                    .foregroundStyle(.gray)
                                    .padding(.horizontal)
                            }else {
                                Text((output.isMarriedEdited ?? (model.isMarried ?? false)) ? "YES".localizedString : "NO".localizedString)
                                    .foregroundStyle(.red)
                                    .padding(.horizontal)
                            }
                            Spacer()
                        }
                    }
                }
                
            }
        }
        .padding(.horizontal)
    }
    
    var childRow: some View {
        VStack(alignment: .leading) {
            if model.isMarried ?? false || model.isMarriedEdited ?? false || output.isMarriedEdited ?? false {
                Text("HAS_CHILDREN_QUESTION".localizedString)
                    .font(.headline)
                    .padding(.horizontal, 4)
                Text(ConverterToString.getAmount(from: model.numberOfChildren))
                    .font(.subheadline)
                    .padding(.horizontal, 4)
                ZStack(alignment: .leading) {
                    Color(hex: "#F5F7FA")
                        .foregroundStyle(.red)
                        .frame(height: 48)
                        .cornerRadius(12)
                    HStack {
                        if let children = model.numberOfChildrenEdited {
                            TextField("\(children)" , text: $output.numberOfChildrenString)
                                .keyboardType(.numberPad)
                                .foregroundStyle(.red)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 8))
                                .background(Color(hex: "#F5F7FA"))
                                .cornerRadius(12)
                        }else {
                            TextField("\(model.numberOfChildrenEdited ?? 0)" , text: $output.numberOfChildrenString)
                                .keyboardType(.numberPad)
                                .foregroundStyle(.red)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 8))
                                .background(Color(hex: "#F5F7FA"))
                                .cornerRadius(12)
                        }
                    }
                    
                }
            }
        }
        .padding(.horizontal)

    }
    
    var dateRow: some View {
        VStack(alignment: .leading) {
            Text("DATE_OF_BIRTH".localizedString)
                .font(.headline)
                .padding(.horizontal, 4)
            Text(model.dateOfBirth ?? "")
                .font(.subheadline)
                .padding(.horizontal, 4)
            ZStack(alignment: .leading) {
                Color(hex: "#F5F7FA")
                    .foregroundStyle(.red)
                    
                    .frame(height: 48)
                    .cornerRadius(12)
                DatePicker(output.date.toShortFormat(), selection: $output.date, in: ...Date(), displayedComponents: .date)
                    .foregroundStyle(.red)
                    .environment(\.locale, Locale.init(identifier: "de_DE"))
                    .id(output.dateID)
                    .onChange(of: output.date, perform: { newValue in
                        output.dateID = UUID()
                    })
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            }
        }
        .padding(.horizontal)
    }
    
    var regionRow: some View {
        VStack(alignment: .leading) {
            Text("REGION".localizedString)
                .font(.headline)
                .padding(.horizontal, 4)
            Text((model.region.name ?? "" + (model.region.parentName ?? "")))
                .font(.subheadline)
                .padding(.horizontal, 4)
            ZStack(alignment: .leading) {
                Color(hex: "#F5F7FA")
                    .foregroundStyle(.red)
                    .frame(height: 48)
                    .cornerRadius(12)
                Menu {
                    ForEach(output.regions, id: \.id) { item in
                        Button {
                            loadChildRegionsTrigger.send(item.id ?? 0)
                            output.parentRegion = item
                            showChildRegions = true
                        } label: {
                            Text(item.name ?? "")
                        }
                    }
                } label: {
                    HStack {
                        if (model.addressEdited == nil || ((model.addressEdited?.isEmpty) != nil)) && output.parentRegion.id == nil {
                            Text("NO_INFORMATION".localizedString)
                                .foregroundStyle(.gray)
                                .padding(.horizontal)
                        }else {
                            Text("")
                                .foregroundStyle(.red)
                                .padding(.horizontal)
                        }
                        Spacer()
                    }
                }
                
                if showChildRegions {
                    Menu {
                        ForEach(output.childRegions, id: \.id) {
                            item in
                            Button {
                                output.childRegionString = item.name ?? ""
                                output.regionEdited = item
                            } label: {
                                Text(item.name ?? "")
                            }
                        }
                    }label: {
                        HStack {
                            Text((output.parentRegion.name ?? "") + ", " + output.childRegionString)
                                .foregroundStyle(.red)
                                .padding(.horizontal)
                            Spacer()
                        }
                    }
                }
            }
        }
        .padding(.horizontal)

    }
    
    var languagesRow: some View {
        VStack(alignment: .leading) {
            Text("FOREIGN_LANGUAGES".localizedString)
                .font(.headline)
                .padding(.horizontal, 4)
            Text(ConverterToString.getStringFrom(model.ownedLanguages))
                .font(.subheadline)
                .padding(.horizontal, 4)
            ZStack(alignment: .leading) {
                Color(hex: "#F5F7FA")
                    .foregroundStyle(.red)
                    .frame(height: 48)
                    .cornerRadius(12)
                Menu {
                    ForEach(output.languages, id: \.id) { item in
                        Button {
                            output.ownedLanguagesEdited.append(ModelWithIdAndName(id: item.id, name: item.name))
                        } label: {
                            Text(item.name ?? "")
                        }

                    }
                } label: {
                    HStack {
                        if model.ownedLanguagesEdited.isEmpty && output.ownedLanguagesEdited.isEmpty {
                            Text("NO_INFORMATION".localizedString)
                                .foregroundStyle(.gray)
                                .padding(.horizontal)
                        }else {
                            Text(ConverterToString.getStringFrom(output.ownedLanguagesEdited))
                                .foregroundStyle(.red)
                                .padding(.horizontal)
                        }
                        Spacer()
                    }
                    
                }
            }
        }
        .padding(.horizontal)

    }
    
    init(viewModel: EditInfographicsViewModel, model: Infographics) {
        let input = EditInfographicsViewModel.Input(
            loadLanguagesDataTrigger: loadLanguagesTrigger.asDriver(),
            loadRegionsDataTrigger: loadRegionsTrigger.asDriver(),
            loadChildRegionsDataTrigger: loadChildRegionsTrigger.asDriver(),
            saveInfographicsTrigger: saveInfographicsTrigger.asDriver(),
            loadInitialValuesTrigger: loadInitialValuesTrigger.asDriver(),
            popViewControllerTrigger: popViewControllerTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        self.model = model
    }
}
