//
//  NewsTableRow.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import URLImage
import Shimmer
struct NewsTableRow: View {
    var viewModel: NewsItemViewModel
    var body: some View {
        VStack(alignment: .leading) {
            CustomImageAndTitleView(urlString: viewModel.imageUrl ?? "", title: viewModel.title ?? "", shortContent: viewModel.shortContent ?? "")
                .padding(.horizontal)
            Divider()
            Text(viewModel.date?.convertToDateUS() ?? "")
                .font(.subheadline)
                .foregroundColor(Color(hex: "#9DA8C2"))
                .padding(6)
                .background(Color.init(hex: "#F7F7F6"))
                .cornerRadius(6)
                .padding()
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(hex: "#E2E5ED"))
        }
    }
}

#Preview {
    NewsTableRow(viewModel: NewsItemViewModel(id: 0, date: "", title: "", shortContent: "", htmlContent: nil, imageUrl: nil))
}
