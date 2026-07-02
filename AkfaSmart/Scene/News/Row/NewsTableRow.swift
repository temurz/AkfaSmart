//
//  NewsTableRow.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import URLImage
import Combine
struct NewsTableRow: View {
    var item: NewsItemViewModel
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
                Text(item.title ?? "")
                    .font(.headline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Text(item.shortContent ?? "")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Divider()
                Text(Date(timeIntervalSince1970: TimeInterval(item.date ?? 1)/1000.0).convertToDateUS())
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "#9DA8C2"))
                    .padding(6)
                    .background(Color(hex: "#F7F7F6"))
                    .cornerRadius(6)
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
            getImageTrigger.send(item.imageUrl ?? "")
        }
    }
    
    init(item: NewsItemViewModel) {
        self.item = item
        let input = ImageDownloaderViewModel.Input(getImageTrigger: getImageTrigger.asDriver())
        
        let vm = ImageDownloaderViewModel()
        self.output = vm.transform(input, cancelBag: cancelBag)
    }
}

#Preview {
    NewsTableRow(item: NewsItemViewModel(id: 0, date: 0, title: "", shortContent: "", htmlContent: nil, imageUrl: nil))
}
