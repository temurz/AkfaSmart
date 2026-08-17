//
//  OrderSuccessDialogView.swift
//  AkfaSmart
//

import SwiftUI
struct OrderSuccessDialogView: View {
    let orderId: Int?
    let onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .foregroundColor(.green)

                if let orderId {
                    Text("#\(orderId)")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Colors.primaryTextColor)
                }

                Text("ORDER_SUBMITTED_SUCCESS".localizedString)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Colors.secondaryTextColor)

                Button {
                    onDismiss()
                } label: {
                    Text("GO_TO_MAIN_SCREEN".localizedString)
                        .foregroundColor(Colors.customRedColor)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Colors.customRedColor)
                        }
                }
            }
            .padding(24)
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal, 32)
        }
    }
}
