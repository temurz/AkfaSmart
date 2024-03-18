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
        VStack(alignment: .leading) {
            if let data = output.imageData {
                Image(data: data)?
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 64)
                    .frame(height: 200)
                    .scaledToFill()
                    .cornerRadius(12)
                    .padding()
            }
            Group {
                Text(itemModel.title ?? "")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding(.top)
                Text(itemModel.shortContent ?? "")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
            .padding(.horizontal)
            Divider()
            HStack {
                Text(itemModel.type ?? "")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(4)
                    .background(Color(hex: itemModel.buttonColor ?? ""))
                    .cornerRadius(6)
                    .padding()
                Spacer()
                Text(itemModel.date?.convertToDateUS() ?? "")
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "#9DA8C2"))
                    .padding(6)
                    .background(Color.init(hex: "#F7F7F6"))
                    .cornerRadius(6)
                    .padding()
            }
        }
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
