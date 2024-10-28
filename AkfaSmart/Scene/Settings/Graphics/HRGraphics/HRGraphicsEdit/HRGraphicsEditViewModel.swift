//
//  HRGraphicsEditViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 13/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct HRGraphicsEditViewModel {
    let useCase: HRGraphicsEditViewUseCaseType
    let navigator: PopViewNavigatorType
}

extension HRGraphicsEditViewModel: ViewModel {
    struct Input {
        let saveHRGraphicsTrigger: Driver<HRGraphics>
        let loadInitialValuesTrigger: Driver<HRGraphics>
        let popViewControllerTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        
        @Published var aboutEmployeesEdited = ""
        @Published var hasAccountantEdited: Bool?
        @Published var hasSellerEdited: Bool?
        @Published var numberOfEmployeesEdited: Int?
        @Published var numberOfEmployeesEditedString = ""
        @Published var userAttendantTrainingsEdited = [ModelWithIdAndName]()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.loadInitialValuesTrigger
            .sink { model in
                output.aboutEmployeesEdited = model.aboutEmployeesEdited ?? ""
                output.hasAccountantEdited = model.hasAccountantEdited
                output.hasSellerEdited = model.hasSellerEdited
                output.numberOfEmployeesEdited = model.numberOfEmployeesEdited
                let string = String(model.numberOfEmployeesEdited ?? -1)
                
                if string != "-1" {
                    output.numberOfEmployeesEditedString = string
                }
                
            }
            .store(in: cancelBag)
        
        input.saveHRGraphicsTrigger
            .sink { model in
                var newModel = model
                
                let aboutEmployeesEdited = output.aboutEmployeesEdited
                let hasAccountantEdited = output.hasAccountantEdited
                let hasSellerEdited = output.hasSellerEdited
                
                var numberOfEmployeesEdited = Int(output.numberOfEmployeesEditedString)
                
                
                newModel.edit(aboutEmployeesEdited: aboutEmployeesEdited, hasAccountantEdited: hasAccountantEdited, hasSellerEdited: hasSellerEdited, numberOfEmployeesEdited: numberOfEmployeesEdited, userAttendantTrainingsEdited: output.userAttendantTrainingsEdited)
                useCase.editHRGraphics(newModel)
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
        
        input.popViewControllerTrigger
            .sink {
                navigator.popView()
            }
            .store(in: cancelBag)
        
        return output
    }
}
