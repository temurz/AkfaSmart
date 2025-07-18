//
//  EditTechnographicsView.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct EditTechnographicsView: View {
    @ObservedObject var output: EditTechnographicsViewModel.Output
    private let loadToolsTrigger = PassthroughSubject<Void,Never>()
    private let saveTechnographicsTrigger = PassthroughSubject<TechnoGraphics, Never>()
    private let loadInitialValuesTrigger = PassthroughSubject<TechnoGraphics,Never>()
    private let popViewControllerTrigger = PassthroughSubject<Void,Never>()
    private let openMapTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    
    private let model: TechnoGraphics
    var body: some View {
        VStack(alignment: .leading) {
            CustomNavigationBar(title: "TECHNOGRAPHICS_TITLE".localizedString, rightBarTitle: "SAVE".localizedString) {
                popViewControllerTrigger.send(())
            } onRightBarButtonTapAction: {
                saveTechnographicsTrigger.send(model)
            }

            ScrollView {
                VStack( spacing: 4) {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("ADDRESS_OF_FACTORY".localizedString)
                                    .font(.headline)
                                    .padding(.horizontal, 4)
                                Text(output.address)
                                    .font(.subheadline)
                                    .padding(.horizontal, 4)
                                if output.locationInfoManager.locationInfo == nil {
                                    Text(output.addressEdited)
                                        .foregroundStyle(.red)
                                        .lineLimit(3)
                                        .padding(4)
                                }else {
                                    Text(output.locationInfoManager.locationInfo?.name ?? "")
                                        .foregroundStyle(.red)
                                        .lineLimit(3)
                                        .padding(4)
                                }
                            }
                            Spacer()
                            Button {
                                openMapTrigger.send(())
                            } label: {
                                Image("location")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .padding(.trailing)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    
                    EditInfographicsViewRow(title: "AREA_OF_FACTORY".localizedString + "SQ_M".localizedString, constantModel: model.area?.convertDecimals(), editedValue: $output.areaEditedString, keyboardType: .numberPad)
                    glassShopRow
                    toolsRow
                }
            }
        }
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            loadInitialValuesTrigger.send(model)
            loadToolsTrigger.send(())
        }
    }
    
    var glassShopRow: some View {
        VStack(alignment: .leading) {
            Text("GLASS_FACTORY_EXISTS".localizedString)
                .font(.headline)
                .padding(.horizontal, 4)
            Text(ConverterToString.getYesOrNoString(model.hasGlassWorkshop))
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
                            output.hasGlassWorkshopEdited = true
                        } label: {
                            Text("YES".localizedString)
                        }
                        Button {
                            output.hasGlassWorkshopEdited = false
                        } label: {
                            Text("NO".localizedString)
                        }

                    } label: {
                        HStack {
                            Text((output.hasGlassWorkshopEdited ?? false) ? "YES".localizedString : "NO".localizedString)
                                .foregroundStyle(.red)
                                .padding(.horizontal)
                            Spacer()
                        }
                        
                    }
                }
            }
        }.padding(.horizontal)
    }
    
    var toolsRow: some View {
        VStack(alignment: .leading) {
            Text("TOOLS".localizedString)
                .font(.headline)
                .padding(.horizontal, 4)
            Text(ConverterToString.getStringFrom(model.tools))
                .font(.subheadline)
                .padding(.horizontal, 4)
//            ZStack(alignment: .leading) {
//                Color(hex: "#F5F7FA")
//                    
//                    .frame(height: 48)
//                    .cornerRadius(12)
                HStack {
                    Menu {
                        ForEach(output.tools, id: \.id) { item in
                            Button {
                                output.toolsEdited.append(item)
                            } label: {
                                Text(item.name ?? "")
                            }
                        }

                    } label: {
                        if output.toolsEdited.isEmpty {
                            Text("NO_INFORMATION".localizedString)
                                .foregroundStyle(.red)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                                .frame(height: 48)
                                .background(Color(hex: "#F5F7FA"))
                                .cornerRadius(12)
                                
                        }else {
                            Text(ConverterToString.getStringFrom(output.toolsEdited))
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .foregroundStyle(.red)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                                .frame(minHeight: 48)
                                .background(Color(hex: "#F5F7FA"))
                                .cornerRadius(12)
                        }
                    }
                }
//            }
            
        }.padding(.horizontal)
    }
    
    init(viewModel: EditTechnographicsViewModel, model: TechnoGraphics) {
        self.model = model
        
        let input = EditTechnographicsViewModel.Input(
            loadToolsTrigger: loadToolsTrigger.asDriver(), 
            saveTechnographicsTrigger: saveTechnographicsTrigger.asDriver(),
            loadInitialValuesTrigger: loadInitialValuesTrigger.asDriver(),
            openMapTrigger: openMapTrigger.asDriver(),
            popViewControllerTrigger: popViewControllerTrigger.asDriver()
        )
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
