//
//  TechnoViewModel.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//


import Foundation
struct TechnoGraphicsViewModel {
    let useCase: TechnoGraphicsViewUseCaseType
}

extension TechnoGraphicsViewModel: ViewModel {
    struct Input {
        let requestTechnoGraphicsTrigger: Driver<Void>
        let showEditTechnoGraphicsViewTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var items = [
            InfoItemViewModel(title: "Цех манзили", value: "Наманган шахри, Лола кўчаси", editedValue: "Наманган шахри, Лола кўчаси"),
            InfoItemViewModel(title: "Цех майдони", value: "100 кв.м.", editedValue: "100 кв.м.")
        ]
        @Published var technoGraphics: TechnoGraphics? = nil
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.requestTechnoGraphicsTrigger
            .map {
                useCase.getTechnoGraphics()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { technoGraphics in
                output.technoGraphics = technoGraphics
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
        
        return output
    }
}
