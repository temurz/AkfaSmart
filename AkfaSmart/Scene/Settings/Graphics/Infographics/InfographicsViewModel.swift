//
//  View.swift
//  AkfaSmart
//
//  Created by Temur on 11/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct InfographicsViewModel {
    let useCase: InfographicsViewUseCaseType
    let navigator: InfographicsViewNavigatorType
}

extension InfographicsViewModel: ViewModel {
    struct Input {
        let requestInfographicsTrigger: Driver<Void>
        let showEditInfographicsViewTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var items = [
            InfoItemViewModel(title: "ФИО", value: "Jack Smith", editedValue: ""),
            InfoItemViewModel(title: "Дата рождения", value: "21.02.1995", editedValue: "")
        ]
        @Published var info: Infographics? = nil
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.requestInfographicsTrigger
            .map {
                useCase.getInfographics()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { infographics in
                output.info = infographics
            })
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
        
        input.showEditInfographicsViewTrigger
            .sink {
                if let info = output.info {
                    navigator.showEditInfographicsView(model: info)
                }
            }
            .store(in: cancelBag)
        
        return output
    }
}
