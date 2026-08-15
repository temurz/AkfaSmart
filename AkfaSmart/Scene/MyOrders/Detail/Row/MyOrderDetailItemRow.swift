//
//  MyOrderDetailItemRow.swift
//  AkfaSmart
//

import SwiftUI
struct MyOrderDetailItemRow: View {
    let item: CartItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.productName ?? "")
                .font(.headline)
                .foregroundColor(Colors.primaryTextColor)
            HStack {
                Text("GROUP_WITH_COLON".localizedString)
                    .foregroundColor(Colors.secondaryTextColor)
                Text(item.groupName ?? "")
                    .foregroundColor(Colors.primaryTextColor)
            }
            HStack {
                Text("QUANTITY_WITH_COLON".localizedString)
                    .foregroundColor(Colors.secondaryTextColor)
                Spacer()
                Text("\(item.quantityInt)")
                    .foregroundColor(Colors.primaryTextColor)
            }
            HStack {
                Text("PRICE".localizedString)
                    .foregroundColor(Colors.secondaryTextColor)
                Spacer()
                Text((item.price?.convertDecimals() ?? "0") + "UZS".localizedString)
                    .foregroundColor(Colors.primaryTextColor)
            }
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
