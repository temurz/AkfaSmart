//
//  MyOrderRow.swift
//  AkfaSmart
//

import SwiftUI
struct MyOrderRow: View {
    let model: OrderSummary

    private var status: OrderListStatus? {
        OrderListStatus(rawValue: model.orderStatus ?? "")
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                Text("ORDER_WITH_NUMBER".localizedString)
                    .foregroundStyle(Colors.textSteelColor)
                    .padding(.trailing, 4)
                Text("\(model.id)")
                    .bold()
                    .foregroundStyle(Colors.textDescriptionColor)
                Spacer()
            }
            HStack(spacing: 0) {
                Text("DEALER".localizedString)
                    .foregroundStyle(Colors.textSteelColor)
                    .padding(.trailing, 4)
                Text(model.dealerName ?? "")
                    .bold()
                    .foregroundStyle(Colors.textDescriptionColor)
                Spacer()
            }
            HStack {
                Text("QUANTITY_WITH_COLON".localizedString)
                    .foregroundStyle(Colors.textSteelColor)
                Spacer()
                Text("\(Int(model.totalQuantity ?? 0))")
                    .bold()
                    .foregroundStyle(Colors.textDescriptionColor)
            }
            HStack {
                Text("STATUS_WITH_COLON".localizedString)
                    .foregroundStyle(Colors.textSteelColor)
                Spacer()
                Text(status?.title ?? model.orderStatus ?? "")
                    .font(.footnote)
                    .bold()
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .foregroundStyle(status == .canceled ? .red : .green)
                    .background((status == .canceled ? Colors.customRedColor : Colors.customGreenBackgroundColor).opacity(0.2))
                    .cornerRadius(5, corners: .allCorners)
            }
            Colors.borderGrayColor
                .frame(height: 1)
            HStack {
                Text("TOTAL_AMOUNT".localizedString)
                    .foregroundStyle(Colors.textSteelColor)
                Spacer()
                Text((model.totalPrice?.convertDecimals() ?? "0") + "UZS".localizedString)
                    .bold()
                    .foregroundStyle(Colors.customRedColor)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}
