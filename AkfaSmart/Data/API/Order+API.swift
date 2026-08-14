//
//  Order+API.swift
//  AkfaSmart
//

import Alamofire
extension API {
    func saveOrderItem(_ input: SaveOrderItemInput) -> Observable<CartItem> {
        request(input)
    }

    final class SaveOrderItemInput: APIInput {
        init(productId: Int, quantity: Int) {
            let parameters: Parameters = [
                "adwProductId": productId,
                "quantity": quantity
            ]
            super.init(urlString: API.Urls.saveOrderItem, parameters: parameters, method: .post, encoding: JSONEncoding.prettyPrinted, requireAccessToken: true)
        }
    }
}

extension API {
    func getCartItems(_ input: GetCartItemsInput) -> Observable<CartSummary> {
        request(input)
    }

    final class GetCartItemsInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getCartItems, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}

extension API {
    func changeOrderItemQuantity(_ input: ChangeOrderItemQuantityInput) -> Observable<Bool> {
        success(input)
    }

    final class ChangeOrderItemQuantityInput: APIInput {
        init(orderItemId: Int, quantity: Int) {
            let parameters: Parameters = [
                "orderItemId": orderItemId,
                "quantity": quantity
            ]
            super.init(urlString: API.Urls.changeOrderItemQuantity, parameters: parameters, method: .put, requireAccessToken: true)
        }
    }
}

extension API {
    func deleteOrderItem(_ input: DeleteOrderItemInput) -> Observable<Bool> {
        success(input)
    }

    final class DeleteOrderItemInput: APIInput {
        init(orderItemId: Int) {
            let url = API.Urls.deleteOrderItem + "/\(orderItemId)"
            super.init(urlString: url, parameters: nil, method: .delete, requireAccessToken: true)
        }
    }
}

extension API {
    func getInCartItemsCount(_ input: GetInCartItemsCountInput) -> Observable<InCartItemsCount> {
        request(input)
    }

    final class GetInCartItemsCountInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getInCartItemsCount, parameters: nil, method: .get, requireAccessToken: true)
        }
    }
}

extension API {
    func addDealerToOrder(_ input: AddDealerToOrderInput) -> Observable<Bool> {
        success(input)
    }

    final class AddDealerToOrderInput: APIInput {
        init(dealerId: Int) {
            let parameters: Parameters = ["dealerId": dealerId]
            super.init(urlString: API.Urls.addDealerToOrder, parameters: parameters, method: .post, requireAccessToken: true)
        }
    }
}

extension API {
    func completeOrder(_ input: CompleteOrderInput) -> Observable<Bool> {
        success(input)
    }

    final class CompleteOrderInput: APIInput {
        init() {
            super.init(urlString: API.Urls.completeOrder, parameters: nil, method: .post, requireAccessToken: true)
        }
    }
}
