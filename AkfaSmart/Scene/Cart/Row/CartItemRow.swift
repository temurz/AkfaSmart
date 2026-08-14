//
//  CartItemRow.swift
//  AkfaSmart
//

import SwiftUI
struct CartItemRow: View {
    let item: CartItem
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    let onRemove: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(item.productName ?? "")
                    .font(.headline)
                    .foregroundColor(Colors.primaryTextColor)
                Spacer()
                Button {
                    onRemove()
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(Colors.customRedColor)
                        .frame(width: 24, height: 24)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
            HStack {
                Text("GROUP_WITH_COLON".localizedString)
                    .foregroundColor(Colors.secondaryTextColor)
                Text(item.groupName ?? "")
                    .foregroundColor(Colors.primaryTextColor)
            }
            HStack {
                Text("PRICE".localizedString)
                    .foregroundColor(Colors.secondaryTextColor)
                Text((item.price?.convertDecimals() ?? "") + "UZS".localizedString)
                    .foregroundColor(Colors.primaryTextColor)
            }
            QuantityStepperView(
                quantity: item.quantityInt,
                minValue: 0,
                onIncrement: onIncrement,
                onDecrement: onDecrement
            )
        }
        .padding()
        .background(.white)
        .cornerRadius(8)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Colors.oldBorderColor)
        }
    }
}
