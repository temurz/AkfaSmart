//
//  SearchDealerUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 22/04/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol SearchDealerUseCaseType {
    func searchDealer() -> Observable<AddDealer>
}

//struct SearchDealerUseCase: SearchDealerUseCaseType {
//   
//}
