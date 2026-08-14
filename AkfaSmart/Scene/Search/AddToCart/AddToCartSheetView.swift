//
//  AddToCartSheetView.swift
//  AkfaSmart
//

import SwiftUI
struct AddToCartSheetView: View {
    let product: ProductWithName
    let onAdd: (Int) -> Void
    let onDismiss: () -> Void

    @State private var quantity = 1

    var body: some View {
        VStack {
            Button {
                onDismiss()
            } label: {
                Color.black.opacity(0.1)
            }

            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("NAME_WITH_COLON".localizedString)
                        .foregroundColor(Colors.secondaryTextColor)
                    Text(product.name ?? "")
                        .foregroundColor(Colors.primaryTextColor)
                    Spacer()
                }
                HStack {
                    Text("GROUP_WITH_COLON".localizedString)
                        .foregroundColor(Colors.secondaryTextColor)
                    Text(product.groupName ?? "")
                        .foregroundColor(Colors.primaryTextColor)
                    Spacer()
                }
                HStack {
                    Text("PRICE".localizedString)
                        .foregroundColor(Colors.secondaryTextColor)
                    Text((product.rate?.convertDecimals() ?? "") + "UZS".localizedString)
                        .foregroundColor(Colors.primaryTextColor)
                    Spacer()
                }

                QuantityStepperView(
                    quantity: quantity,
                    onIncrement: { quantity += 1 },
                    onDecrement: { if quantity > 1 { quantity -= 1 } }
                )

                Button {
                    onAdd(quantity)
                } label: {
                    Text("ADD_TO_CART".localizedString)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Colors.customRedColor)
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea(.all)
        .background(Color.clear)
    }
}
