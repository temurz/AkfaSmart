//
//  MyOrdersViewUseCase.swift
//  AkfaSmart
//

import Foundation
protocol MyOrdersViewUseCaseType {
    func getAllOrdersList(status: String, page: Int) -> Observable<PagingInfo<OrderSummary>>
}

struct MyOrdersViewUseCase: MyOrdersViewUseCaseType, GettingOrderListDomainUseCase {
    var gateway: OrderGatewayType
}
