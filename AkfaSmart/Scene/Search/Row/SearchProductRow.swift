//
//  SearchProductRow.swift
//  AkfaSmart
//

import SwiftUI
struct SearchProductRow: View {
    var model: ProductWithName

    var onSelectCard: (() -> Void)?
    var onSelectLocation: (() -> Void)?
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .top) {
                Text(model.groupName ?? "")
                    .font(.caption)
                    .foregroundColor(Color(hex: "#9497A1"))
                    .lineLimit(1)
                Spacer()
                Button {
                    onSelectLocation?()
                } label: {
                    Image("location")
                        .renderingMode(.template)
                        .resizable()
                        .foregroundStyle(.red)
                        .frame(width: 20, height: 20)
                }
            }

            Text((model.rate?.convertDecimals() ?? "") + "UZS".localizedString)
                .font(.subheadline)
                .bold()
                .foregroundColor(.green)

            Text(model.name ?? "")
                .font(.subheadline)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .lineLimit(2)

            Spacer(minLength: 0)
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 120, alignment: .top)
        .background(.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .onTapGesture {
            onSelectCard?()
        }
    }
}
