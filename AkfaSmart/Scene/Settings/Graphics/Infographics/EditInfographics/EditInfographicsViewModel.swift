//
//  EditInfographicsViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 12/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct EditInfographicsViewModel {
    let useCase: EditInfographicsViewUseCaseType
    let navigator: EditInfoGraphicsViewNavigatorType
}

extension EditInfographicsViewModel: ViewModel {
    struct Input {
        let loadLanguagesDataTrigger: Driver<Void>
        let loadRegionsDataTrigger: Driver<Void>
        let loadChildRegionsDataTrigger: Driver<Int>
        let saveInfographicsTrigger: Driver<Infographics>
        let loadInitialValuesTrigger: Driver<Infographics>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var languages = [ModelWithIdAndName]()
        @Published var regions = [Region]()
        @Published var childRegions = [Region]()
        
        @Published var initialValuesAreLoaded = 0
        
        @Published var firstName = ""
        @Published var middleName = ""
        @Published var lastName = ""
        @Published var isMarriedEdited: Bool?
        @Published var dateOfBirth: String = ""
        @Published var address: String = ""
        @Published var nation: String = ""
        @Published var educationEdited: String = ""
        @Published var ownedLanguagesEdited: [ModelWithIdAndName] = []
        @Published var numberOfChildrenEdited: Int = 0
        @Published var regionEdited: Region = Region()
        
        @Published var date: Date = Date()
        @Published var dateID = UUID()
        
        @Published var parentRegion = Region()
        @Published var childRegionString = ""
        
        @Published var numberOfChildrenString = ""
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.loadLanguagesDataTrigger
            .sink {
                useCase.getLanguages()
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { languages in
                        output.languages = languages
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        input.loadRegionsDataTrigger
            .sink {
                useCase.loadRegions(parentId: nil)
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { regions in
                        output.regions = regions
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        input.loadChildRegionsDataTrigger
            .sink { id in
                useCase.loadRegions(parentId: id)
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { childRegions in
                        output.childRegions = childRegions
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        input.loadInitialValuesTrigger
            .sink { model in
                output.firstName = model.firstNameEdited ?? ""
                output.middleName = model.middleNameEdited ?? ""
                output.lastName = model.lastNameEdited ?? ""
                output.isMarriedEdited = model.isMarriedEdited
                output.dateOfBirth = model.dateOfBirthEdited ?? ""
                output.address = model.addressEdited ?? ""
                output.nation = model.nationEdited ?? ""
                output.educationEdited = model.educationEdited ?? ""
                output.ownedLanguagesEdited = model.ownedLanguagesEdited
                output.numberOfChildrenEdited = model.numberOfChildrenEdited ?? 0
                output.numberOfChildrenString = "\(model.numberOfChildren ?? (model.numberOfChildrenEdited ?? 0))"
                output.regionEdited = model.regionEdited
                
                output.date = model.dateOfBirthEdited?.revertToDate() ?? Date()
                
                output.initialValuesAreLoaded += 1
            }
            .store(in: cancelBag)
        
        
        input.saveInfographicsTrigger
            .sink { model in
                var model = model
                
                let firstname = output.firstName
                let middleName = output.middleName
                let lastName = output.lastName
                let isMarriedEdited = output.isMarriedEdited
                
                let address = output.address
                let nation = output.nation
                let educationEdited = output.educationEdited
                let ownedLanguagesEdited = output.ownedLanguagesEdited
                
                let regionEdited = output.regionEdited.id == nil ? output.parentRegion : output.regionEdited
                
                var dateOfBirth = output.dateOfBirth
                if !Calendar(identifier: .gregorian).isDateInToday(output.date) {
                    dateOfBirth = output.date.toLongAPIFormat()
                }
                var numberOfChildrenEdited: Int = output.numberOfChildrenEdited
                
                if output.numberOfChildrenEdited != Int(output.numberOfChildrenString) {
                    if let num = Int(output.numberOfChildrenString) {
                        numberOfChildrenEdited = num
                    }
                }
                
                
                
                
                model.edit(firstNameEdited: firstname, lastNameEdited: lastName, middleNameEdited: middleName, isMarriedEdited: isMarriedEdited, dateOfBirth: dateOfBirth, address: address, nation: nation, educationEdited: educationEdited, ownedLanguagesEdited: ownedLanguagesEdited, numberOfChildrenEdited: numberOfChildrenEdited, regionEdited: regionEdited)
                
                useCase.editInfographics(infographics: model)
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
