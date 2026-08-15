//
//  OrderGateway.swift
//  AkfaSmart
//

import Foundation
protocol OrderGatewayType {
    func saveOrderItem(productId: Int, quantity: Int) -> Observable<CartItem>
    func getCartItems() -> Observable<CartSummary>
    func changeOrderItemQuantity(orderItemId: Int, quantity: Int) -> Observable<Bool>
    func deleteOrderItem(orderItemId: Int) -> Observable<Bool>
    func getInCartItemsCount() -> Observable<Int>
    func addDealerToOrder(dealerId: Int) -> Observable<Bool>
    func completeOrder() -> Observable<Bool>
    func getAllOrdersList(status: String, dto: GetPageDto) -> Observable<PagingInfo<OrderSummary>>
    func getOrderItems(orderId: Int) -> Observable<[CartItem]>
    func cancelOrder(orderId: Int) -> Observable<Bool>
}

struct OrderGateway: OrderGatewayType {
    func saveOrderItem(productId: Int, quantity: Int) -> Observable<CartItem> {
        API.shared.saveOrderItem(API.SaveOrderItemInput(productId: productId, quantity: quantity))
    }

    func getCartItems() -> Observable<CartSummary> {
        API.shared.getCartItems(API.GetCartItemsInput())
    }

    func changeOrderItemQuantity(orderItemId: Int, quantity: Int) -> Observable<Bool> {
        API.shared.changeOrderItemQuantity(API.ChangeOrderItemQuantityInput(orderItemId: orderItemId, quantity: quantity))
    }

    func deleteOrderItem(orderItemId: Int) -> Observable<Bool> {
        API.shared.deleteOrderItem(API.DeleteOrderItemInput(orderItemId: orderItemId))
    }

    func getInCartItemsCount() -> Observable<Int> {
        API.shared.getInCartItemsCount(API.GetInCartItemsCountInput())
            .map { $0.count ?? 0 }
            .eraseToAnyPublisher()
    }

    func addDealerToOrder(dealerId: Int) -> Observable<Bool> {
        API.shared.addDealerToOrder(API.AddDealerToOrderInput(dealerId: dealerId))
    }

    func completeOrder() -> Observable<Bool> {
        API.shared.completeOrder(API.CompleteOrderInput())
    }

    func getAllOrdersList(status: String, dto: GetPageDto) -> Observable<PagingInfo<OrderSummary>> {
        API.shared.getAllOrdersList(API.GetAllOrdersListInput(status: status, dto: dto))
            .map { PagingInfo(page: dto.page, items: $0, hasMorePages: $0.count == dto.perPage) }
            .eraseToAnyPublisher()
    }

    func getOrderItems(orderId: Int) -> Observable<[CartItem]> {
        API.shared.getOrderItems(API.GetOrderItemsInput(orderId: orderId))
    }

    func cancelOrder(orderId: Int) -> Observable<Bool> {
        API.shared.cancelOrder(API.CancelOrderInput(orderId: orderId))
    }
}
