//
//  AddDealerUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 12/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol AddDealerUseCaseType {
    func sendQRCode(_ qrCode: String) -> Observable<AddDealer>
    func requestSMSCode(_ dealer: AddDealer) -> Observable<Bool>
    func confirmSMSCode(_ dealer: AddDealer, code: String) -> Observable<Bool>
}

struct AddDealerUseCase: AddDealerUseCaseType, AddDealerDomainUseCase {
    var gateway: AddDealerGatewayType
}

protocol ConfirmDealerUseCaseType {
    func confirmSMSCode(_ dealer: AddDealer, code: String) -> Observable<Bool>
}

struct ConfirmDealerUseCase: ConfirmDealerUseCaseType, AddDealerDomainUseCase {
    var gateway: AddDealerGatewayType
}
