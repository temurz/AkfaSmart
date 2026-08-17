//
//  ProductGroupPickerSheetView.swift
//  AkfaSmart
//

import SwiftUI
struct ProductGroupPickerSheetView: View {
    let rootGroups: [ProductGroup]
    let onSelect: (ProductGroup?) -> Void
    let onDismiss: () -> Void

    @State private var stack: [ProductGroup] = []

    private var currentLevel: [ProductGroup] {
        stack.last?.children ?? rootGroups
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                if !stack.isEmpty {
                    Button {
                        stack.removeLast()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Colors.primaryTextColor)
                    }
                    .padding(.trailing, 8)
                }
                Text(stack.last?.text ?? "SELECT_GROUP".localizedString)
                    .font(.headline)
                    .lineLimit(1)
                Spacer()
                Button {
                    onDismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Colors.secondaryTextColor)
                }
            }
            .padding(.horizontal)
            .padding(.top, 24)
            .padding(.bottom)

            if stack.isEmpty {
                Button {
                    onSelect(nil)
                } label: {
                    HStack {
                        Text("ALL_GROUPS".localizedString)
                            .foregroundColor(Colors.primaryTextColor)
                        Spacer()
                    }
                    .padding()
                }
                Divider()
            }

            ScrollView {
                ForEach(currentLevel) { group in
                    Button {
                        if let children = group.children, !children.isEmpty {
                            stack.append(group)
                        } else {
                            onSelect(group)
                        }
                    } label: {
                        HStack {
                            Text(group.text)
                                .foregroundColor(Colors.primaryTextColor)
                            Spacer()
                            if let children = group.children, !children.isEmpty {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Colors.secondaryTextColor)
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
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}
