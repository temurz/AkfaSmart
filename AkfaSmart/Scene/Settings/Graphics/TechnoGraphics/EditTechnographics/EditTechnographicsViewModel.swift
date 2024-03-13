//
//  EditTechnographicsViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct EditTechnographicsViewModel {
    let navigator: PopViewNavigatorType
    let useCase: EditTechnographicsUseCaseType
}

extension EditTechnographicsViewModel: ViewModel {
    struct Input {
        let loadToolsTrigger: Driver<Void>
        let saveTechnographicsTrigger: Driver<TechnoGraphics>
        let loadInitialValuesTrigger: Driver<TechnoGraphics>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var tools = [ModelWithIdAndName]()
        
        @Published var areaEdited: Double? = nil
        @Published var areaEditedString = ""
        @Published var hasGlassWorkshopEdited: Bool?
        @Published var toolsEdited = [ModelWithIdAndName]()
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
                
                newModel.edit(longitudeEdited: model.longitudeEdited, latitudeEdited: model.latitudeEdited, areaEdited: newArea, hasGlassWorkshopEdited: output.hasGlassWorkshopEdited, toolsEdited: output.toolsEdited)
                
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
        
        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0)}
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
