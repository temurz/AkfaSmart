//
//  SheetHeightReader.swift
//  AkfaSmart
//

import SwiftUI

private struct SheetHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func readSheetHeight(into height: Binding<CGFloat>) -> some View {
        overlay {
            GeometryReader { proxy in
                Color.clear.preference(key: SheetHeightPreferenceKey.self, value: proxy.size.height)
            }
        }
        .onPreferenceChange(SheetHeightPreferenceKey.self) { height.wrappedValue = $0 }
    }
}
