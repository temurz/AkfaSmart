//
//  DealerPickerSheetView.swift
//  AkfaSmart
//

import SwiftUI
struct DealerPickerSheetView: View {
    let dealers: [Dealer]
    let selected: Dealer?
    let onSelect: (Dealer) -> Void
    let onDismiss: () -> Void

    var body: some View {
        VStack {
            Button {
                onDismiss()
            } label: {
                Color.black.opacity(0.1)
            }

            VStack(alignment: .leading, spacing: 0) {
                Text("SELECT_DEALER".localizedString)
                    .font(.headline)
                    .padding()

                ScrollView {
                    ForEach(dealers, id: \.dealerClientCid) { dealer in
                        Button {
                            onSelect(dealer)
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(dealer.name ?? "")
                                        .foregroundColor(Colors.primaryTextColor)
                                    Text((dealer.balance?.convertDecimals() ?? "") + "SUM_UZS".localizedString)
                                        .font(.subheadline)
                                        .foregroundColor(dealer.balance ?? 0 >= 0 ? .green : .red)
                                }
                                Spacer()
                                if dealer == selected {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Colors.customRedColor)
                                }
                            }
                            .padding()
                        }
                        Divider()
                    }
                }
                .frame(maxHeight: 400)
            }
            .padding(.bottom)
            .background(Color.white)
            .cornerRadius(12, corners: [.topLeft, .topRight])
        }
        .ignoresSafeArea(.all)
        .background(Color.clear)
    }
}
