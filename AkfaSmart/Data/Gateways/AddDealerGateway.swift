//
//  AddDealerGateway.swift
//  AkfaSmart
//
//  Created by Temur on 26/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol AddDealerGatewayType {
    func sendQRCode(_ qrCode: String) -> Observable<AddDealer>
    func requestSMSCode(_ dealer: AddDealer) -> Observable<Bool>
    func confirmSMSCode(_ dealer: AddDealer, code: String) -> Observable<Bool>
}

struct AddDealerGateway: AddDealerGatewayType {
    func sendQRCode(_ qrCode: String) -> Observable<AddDealer> {
        let input = API.SendQRCodeAPIInput(qrCode)
        return API.shared.sendQRCode(input)
    }
    
    func requestSMSCode(_ dealer: AddDealer) -> Observable<Bool> {
        let input = API.RequestSMSForAddDealer(dealer)
        return API.shared.requestSMS_forAddDealer(input)
    }
    
    func confirmSMSCode(_ dealer: AddDealer, code: String) -> Observable<Bool> {
        let input = API.ConfirmSMSForAddDealerInput(dealer, code: code)
        return API.shared.confirmSMS_forAddDealer(input)
    }
}
