//
//  ArticleDetailView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import UIKit
struct ArticleDetailView: View {
    let itemModel: ArticleItemViewModel
    @ObservedObject var output: ImageDownloaderViewModel.Output
    @StateObject var downloadModel = DownloadTaskModel()
    
    var navigationContoller: UINavigationController
    
    private let getImageTrigger = PassthroughSubject<String,Never>()
    private let cancelBag = CancelBag()
    
    var body: some View {
        VStack {
            CustomNavigationBar(title: itemModel.title ?? "") {
                navigationContoller.popViewController(animated: true)
            }
            ScrollView {
                VStack {
                    if let data = output.imageData {
                        Image(data: data)?
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 64)
                            .frame(height: 200)
                            .scaledToFill()
                            .cornerRadius(12)
                            .padding()
                    }
                }
                VStack(alignment: .leading) {
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
                                Image(systemName: "arrow.down.circle")
                                    .resizable()
                                    .foregroundStyle(.blue)
                                    .frame(width: 24, height: 24)
                                    .padding()
                                Text(item.name ?? "")
                                    .bold()
                                    .foregroundStyle(.blue)
                                    .font(.subheadline)
                                Spacer()
                            }
                            .frame(height: 60)
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                    .frame(height: CGFloat(itemModel.fileUrls.count) * 60)
                    .listStyle(.plain)
                    .background(.clear)
                }
                .padding(.horizontal)
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
    
    init(itemModel: ArticleItemViewModel, navigationController: UINavigationController) {
        self.itemModel = itemModel
        let input = ImageDownloaderViewModel.Input(getImageTrigger: getImageTrigger.asDriver())
        self.output = ImageDownloaderViewModel().transform(input, cancelBag: cancelBag)
        self.navigationContoller = navigationController
    }
}

#Preview {
    ArticleDetailView(itemModel: ArticleItemViewModel(id: 0, date: nil, title: nil, shortContent: nil, htmlContent: nil, imageUrl: nil, type: nil, buttonColor: nil, fileUrls: []), navigationController: UINavigationController())
}
