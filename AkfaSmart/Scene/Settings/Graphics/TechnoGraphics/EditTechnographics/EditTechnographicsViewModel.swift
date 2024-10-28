//
//  EditTechnographicsViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct EditTechnographicsViewModel {
    let navigator: EditTechnographicsNavigatorType
    let useCase: EditTechnographicsUseCaseType
}

extension EditTechnographicsViewModel: ViewModel {
    struct Input {
        let loadToolsTrigger: Driver<Void>
        let saveTechnographicsTrigger: Driver<TechnoGraphics>
        let loadInitialValuesTrigger: Driver<TechnoGraphics>
        let openMapTrigger: Driver<Void>
        let popViewControllerTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var tools = [ModelWithIdAndName]()
        
        @Published var areaEdited: Double? = nil
        @Published var areaEditedString = ""
        @Published var hasGlassWorkshopEdited: Bool?
        @Published var toolsEdited = [ModelWithIdAndName]()
        @Published var locationInfoManager = LocationInfoManager()
        @Published var address = ""
        @Published var addressEdited = ""
        @Published var latEdited: Double?
        @Published var longEdited: Double?
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.loadToolsTrigger
            .sink {
                useCase.getTools()
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { tools in
                        output.tools = tools
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        input.loadInitialValuesTrigger
            .sink { model in
                output.areaEdited = model.areaEdited
                output.areaEditedString = "\(model.areaEdited ?? 0.0)"
                output.hasGlassWorkshopEdited = model.hasGlassWorkshopEdited
                output.toolsEdited = model.toolsEdited
                if let lat = model.latitude, let long = model.longitude {
                    ConverterToString.reverseGeocode(latitude: lat, longitude: long) { address in
                        output.address = address
                    }
                }
                if let lat = model.latitudeEdited, let long = model.longitudeEdited {
                    output.latEdited = lat
                    output.longEdited = long
                    ConverterToString.reverseGeocode(latitude: lat, longitude: long) { address in
                        output.addressEdited = address
                    }
                }
                
            }
            .store(in: cancelBag)
        
        input.saveTechnographicsTrigger
            .sink { model in
                var newModel = model
                
                var newArea = model.areaEdited
                if let area = Double(output.areaEditedString) {
                    if output.areaEdited != area {
                        newArea = area
                    }
                }
                
                var latitude = output.locationInfoManager.locationInfo?.latitude
                var longitude = output.locationInfoManager.locationInfo?.longitude
                if latitude == nil || longitude == nil {
                    latitude = output.latEdited
                    longitude = output.longEdited
                }
                
                newModel.edit(longitudeEdited: longitude, latitudeEdited: latitude, areaEdited: newArea, hasGlassWorkshopEdited: output.hasGlassWorkshopEdited, toolsEdited: output.toolsEdited)
                
                useCase.save(newModel)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { bool in
                        if bool {
                            navigator.popView()
                        }
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        input.openMapTrigger
            .sink {
                navigator.openMap(output.locationInfoManager)
            }
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0)}
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        input.popViewControllerTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)
        
        return output
    }
}
