//
//  AddDealerAPI.swift
//  AkfaSmart
//
//  Created by Temur on 26/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
import Alamofire
extension API {
    func sendQRCode(_ input: SendQRCodeAPIInput) -> Observable<AddDealer> {
        request(input)
    }
    
    final class SendQRCodeAPIInput: APIInput {
        init(_ qrCode: String) {
            let params: Parameters = [
                "qrcode": qrCode
            ]
            super.init(urlString: API.Urls.addDealer_sendQRCode, parameters: params, method: .post, requireAccessToken: true)
        }
    }
}


extension API {
    func requestSMS_forAddDealer(_ input: RequestSMSForAddDealer) -> Observable<Bool> {
        success(input)
    }
    
    final class RequestSMSForAddDealer: APIInput {
        init(_ dealer: AddDealer) {
            let params: Parameters = [
                "printableName": dealer.printableName ?? "",
                "cid": dealer.cid ?? "",
                "dealerId": dealer.dealerId ?? "",
                "phone": dealer.phone ?? ""
            ]
            super.init(urlString: API.Urls.addDealer_requestSMSCode, parameters: params, method: .post,encoding: JSONEncoding.prettyPrinted, requireAccessToken: true)
        }
    }
}

extension API {
    func confirmSMS_forAddDealer(_ input: ConfirmSMSForAddDealerInput) -> Observable<Bool> {
        success(input)
    }
    
    final class ConfirmSMSForAddDealerInput: APIInput {
        init(_ dealer: AddDealer, code: String) {
            let params: Parameters = [
                "printableName": dealer.printableName ?? "",
                "cid": dealer.cid ?? "",
                "dealerId": dealer.dealerId ?? "",
                "phone": dealer.phone ?? ""
            ]
            var url = API.Urls.addDealer_confirmSMSCode
            url.append("?activationCode=\(code)")
            super.init(urlString: url, parameters: params, method: .post, encoding: JSONEncoding.prettyPrinted, requireAccessToken: true)
        }
    }
}
