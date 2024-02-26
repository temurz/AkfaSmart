//
//  HRViewModel.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct HRgraphicsViewModel {
    
}

extension HRgraphicsViewModel: ViewModel {
    struct Input {
        
    }
    
    final class Output: ObservableObject {
        @Published var items = [
            InfoItemViewModel(title: "Ходимлар сони", value: "8 та. Шулардан: 4 та уста, 3 та монтажчилар, 1 та сотувчи", editedValue: "8 та. Шулардан: 4 та уста, 3 та монтажчилар, 1 та сотувчи"),
            InfoItemViewModel(title: "Қайси серияни ясай олади", value: "5200, 6000 куаттро, 6000 трио, 7000 Акфа", editedValue: "5200, 6000 куаттро, 6000 трио, 7000 Акфа")
        ]
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        return output
    }
}
