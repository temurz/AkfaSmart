//
//  CartViewUseCase.swift
//  AkfaSmart
//

import Foundation
protocol CartViewUseCaseType {
    func getDealers() -> Observable<[Dealer]>
    func getCartItems() -> Observable<CartSummary>
    func changeOrderItemQuantity(orderItemId: Int, quantity: Int) -> Observable<Bool>
    func deleteOrderItem(orderItemId: Int) -> Observable<Bool>
    func addDealerToOrder(dealerId: Int) -> Observable<Bool>
    func completeOrder() -> Observable<Bool>
}

struct CartViewUseCase: CartViewUseCaseType, GetDealersDomainUseCase {
    var gateway: GetDealersGatewayType
    var orderGateway: OrderGatewayType

    func getCartItems() -> Observable<CartSummary> {
        orderGateway.getCartItems()
    }

    func changeOrderItemQuantity(orderItemId: Int, quantity: Int) -> Observable<Bool> {
        orderGateway.changeOrderItemQuantity(orderItemId: orderItemId, quantity: quantity)
    }

    func deleteOrderItem(orderItemId: Int) -> Observable<Bool> {
        orderGateway.deleteOrderItem(orderItemId: orderItemId)
    }

    func addDealerToOrder(dealerId: Int) -> Observable<Bool> {
        orderGateway.addDealerToOrder(dealerId: dealerId)
    }

    func completeOrder() -> Observable<Bool> {
        orderGateway.completeOrder()
    }
}
