//
//  CartManager.swift
//  AkfaSmart
//

import Foundation
import Combine
final class CartManager: ObservableObject {
    static let shared = CartManager()

    @Published private(set) var count = 0

    private let gateway: OrderGatewayType
    private let cancelBag = CancelBag()

    private init(gateway: OrderGatewayType = OrderGateway()) {
        self.gateway = gateway
    }

    func refreshCount() {
        gateway.getInCartItemsCount()
            .receive(on: RunLoop.main)
            .map { [weak self] count in self?.count = count }
            .sink()
            .store(in: cancelBag)
    }
}
