//
//  ArticleRow.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct ArticleRow: View {
    let itemModel: ArticleItemViewModel
    @ObservedObject var output: ImageDownloaderViewModel.Output
    
    private let getImageTrigger = PassthroughSubject<String,Never>()
    private let cancelBag = CancelBag()
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let data = output.imageData {
                Image(data: data)?
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(12, corners: [.topLeft, .topRight])
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(itemModel.title ?? "")
                    .font(.headline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Text(itemModel.shortContent ?? "")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Divider()
                HStack {
                    Text(itemModel.type ?? "")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(4)
                        .background(Color(hex: itemModel.buttonColor ?? ""))
                        .cornerRadius(6)
                    Spacer()
                    Text(Date(timeIntervalSince1970: TimeInterval(itemModel.date ?? 1)/1000.0).convertToDateUS())
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#9DA8C2"))
                        .padding(6)
                        .background(Color(hex: "#F7F7F6"))
                        .cornerRadius(6)
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(hex: "#E2E5ED"))
        }
        .onAppear {
            getImageTrigger.send(itemModel.imageUrl ?? "")
        }
    }
    
    init(itemModel: ArticleItemViewModel) {
        self.itemModel = itemModel
        let input = ImageDownloaderViewModel.Input(getImageTrigger: getImageTrigger.asDriver())
        self.output = ImageDownloaderViewModel().transform(input, cancelBag: cancelBag)
    }
}

#Preview {
    ArticleRow(itemModel: ArticleItemViewModel(id: 0, date: nil, title: nil, shortContent: nil, htmlContent: nil, imageUrl: nil, type: nil, buttonColor: nil, fileUrls: []))
}
