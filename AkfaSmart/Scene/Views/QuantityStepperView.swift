//
//  QuantityStepperView.swift
//  AkfaSmart
//

import SwiftUI
struct QuantityStepperView: View {
    let quantity: Int
    var minValue: Int = 1
    let onIncrement: () -> Void
    let onDecrement: () -> Void

    var body: some View {
        HStack {
            stepperBox {
                Button {
                    onDecrement()
                } label: {
                    Image(systemName: "minus")
                        .foregroundColor(Colors.primaryTextColor)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .disabled(quantity <= minValue)
            }
            Spacer()
            stepperBox {
                Text("\(quantity)")
                    .font(.headline)
            }
            Spacer()
            stepperBox {
                Button {
                    onIncrement()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(Colors.primaryTextColor)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func stepperBox<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Colors.oldBorderColor)
            }
    }
}
