//
//  HRViewModel.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct HRgraphicsViewModel {
    let useCase: HRGraphicsViewUseCaseType
}

extension HRgraphicsViewModel: ViewModel {
    struct Input {
        let requestHRGraphicsTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var items = [
            InfoItemViewModel(title: "Ходимлар сони", value: "8 та. Шулардан: 4 та уста, 3 та монтажчилар, 1 та сотувчи", editedValue: "8 та. Шулардан: 4 та уста, 3 та монтажчилар, 1 та сотувчи"),
            InfoItemViewModel(title: "Қайси серияни ясай олади", value: "5200, 6000 куаттро, 6000 трио, 7000 Акфа", editedValue: "5200, 6000 куаттро, 6000 трио, 7000 Акфа")
        ]
        @Published var hrGraphics: HRGraphics? = nil
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.requestHRGraphicsTrigger
            .map {
                useCase.getHRGraphics()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { hrGraphics in
                output.hrGraphics = hrGraphics
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
