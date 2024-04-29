//
//  AddDealerDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 26/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol AddDealerDomainUseCase {
    var gateway: AddDealerGatewayType { get }
}

extension AddDealerDomainUseCase {
    func sendQRCode(_ qrCode: String) -> Observable<AddDealer> {
        gateway.sendQRCode(qrCode)
    }
    
    func requestSMSCode(_ dealer: AddDealer) -> Observable<Bool> {
        gateway.requestSMSCode(dealer)
    }
    
    func confirmSMSCode(_ dealer: AddDealer, code: String) -> Observable<Bool> {
        gateway.confirmSMSCode(dealer, code: code)
    }
}

extension AddDealerDomainUseCase {
    func requestSMSCodeForActiveDealer(_ dealer: AddDealer) -> Observable<GetUserInfoResponse> {
        return gateway.requestSMSCodeForActiveDealer(dealer)
    }
    
    func confirmSMSCodeForActiveDealer(_ dealer: AddDealer, code: String) -> Observable<Bool> {
        gateway.confirmSMSCodeForActiveDealer(dealer, code: code)
    }
}
