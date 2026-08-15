//
//  GettingOrderListDomainUseCase.swift
//  AkfaSmart
//

import Foundation
protocol GettingOrderListDomainUseCase {
    var gateway: OrderGatewayType { get }
}

extension GettingOrderListDomainUseCase {
    func getAllOrdersList(status: String, page: Int) -> Observable<PagingInfo<OrderSummary>> {
        gateway.getAllOrdersList(status: status, dto: GetPageDto(page: page))
    }
}
