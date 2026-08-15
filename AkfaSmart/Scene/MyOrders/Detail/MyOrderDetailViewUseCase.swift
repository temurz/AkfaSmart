//
//  MyOrderDetailViewUseCase.swift
//  AkfaSmart
//

import Foundation
protocol MyOrderDetailViewUseCaseType {
    func getOrderItems(orderId: Int) -> Observable<[CartItem]>
    func cancelOrder(orderId: Int) -> Observable<Bool>
}

struct MyOrderDetailViewUseCase: MyOrderDetailViewUseCaseType {
    var gateway: OrderGatewayType

    func getOrderItems(orderId: Int) -> Observable<[CartItem]> {
        gateway.getOrderItems(orderId: orderId)
    }

    func cancelOrder(orderId: Int) -> Observable<Bool> {
        gateway.cancelOrder(orderId: orderId)
    }
}
