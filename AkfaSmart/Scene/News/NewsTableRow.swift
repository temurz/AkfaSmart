//
//  NewsTableRow.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI

struct NewsTableRow: View {
    @Binding var newsItem: NewsItemViewModel
    var body: some View {
        VStack {
            Image(newsItem.imageUrl ?? "")
                .resizable()
                .frame(maxWidth: .infinity)
                .padding()
            Text(newsItem.title ?? "")
                .font(.title)
                .padding()
            Text(newsItem.shortContent ?? "")
                .font(.footnote)
                .foregroundColor(Color.gray)
            Divider()
            Text(newsItem.date ?? "")
        }
    }
}

#Preview {
    NewsTableRow(newsItem: .constant(NewsItemViewModel(id: 0, date: "", title: "", shortContent: "", htmlContent: nil, imageUrl: nil)))
}
