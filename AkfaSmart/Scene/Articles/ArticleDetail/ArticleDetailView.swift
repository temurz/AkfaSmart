//
//  ArticleDetailView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct ArticleDetailView: View {
    let itemModel: ArticleItemViewModel
    @ObservedObject var output: ImageDownloaderViewModel.Output
    @StateObject var downloadModel = DownloadTaskModel()
    private let getImageTrigger = PassthroughSubject<String,Never>()
    private let cancelBag = CancelBag()
    
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    if let data = output.imageData {
                        CustomImageAndTitleView(data: data)
                    }
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
                if let htmlContent = itemModel.htmlContent, !htmlContent.isEmpty {
                    WebView(html: htmlContent)
                        .frame(height: UIScreen.main.bounds.height * 0.6)
                }
                
                List(itemModel.fileUrls, id: \.url) { item in
                    Button {
                        downloadModel.startDownload(urlString: item.url ?? "")
                    } label: {
                        HStack {
                            Text(item.name ?? "")
                                .bold()
                                .font(.subheadline)
                        }
                        .frame(height: 50)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .frame(height: CGFloat(itemModel.fileUrls.count) * 50)
                .listStyle(.plain)
                .background(.clear)
            }

        }
        .onAppear {
            getImageTrigger.send(itemModel.imageUrl ?? "")
        }
        .alert(isPresented: $downloadModel.showAlert) {
            Alert(title: Text("Message"), message: Text(downloadModel.alertMsg), dismissButton: .destructive(Text("OK".localizedString), action: {
                
            })
            )
        }
        .overlay {
            if downloadModel.showDownloadProgress {
                ZStack {
                    DownloadProgressView(progress: $downloadModel.downloadProgress)
                        .environmentObject(downloadModel)
                }
            }
        }
    }
    
    init(itemModel: ArticleItemViewModel) {
        self.itemModel = itemModel
        let input = ImageDownloaderViewModel.Input(getImageTrigger: getImageTrigger.asDriver())
        self.output = ImageDownloaderViewModel().transform(input, cancelBag: cancelBag)
    }
}

#Preview {
    ArticleDetailView(itemModel: ArticleItemViewModel(id: 0, date: nil, title: nil, shortContent: nil, htmlContent: nil, imageUrl: nil, type: nil, buttonColor: nil, fileUrls: []))
}
