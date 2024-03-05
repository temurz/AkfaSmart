//
//  ArticlesView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import SwiftUIRefresh
struct ArticlesView: View {
    
    @ObservedObject var output: ArticlesViewModel.Output
    let showDetailViewTrigger = PassthroughSubject<ArticleItemViewModel, Never>()
    let loadArticlesTrigger = PassthroughSubject<Void, Never>()
    let reloadArticlesTrigger = PassthroughSubject<Void,Never>()
    let loadMoreArticlesTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack() {
                List {
                    ForEach(output.articles) { article in
                        Button(action: {
                            showDetailViewTrigger.send(article)
                        }) {
                            ArticleRow(itemModel: article)
                                .onAppear {
                                    if output.articles.last?.id ?? -1 == article.id && output.hasMorePages {
                                        output.isLoadingMore = true
                                        self.loadMoreArticlesTrigger.send(())
                                    }
                                }
                        }
                        .listRowSeparator(.hidden)
                    }
                    if output.isLoadingMore {
                        HStack {
                            Spacer()
                            ActivityIndicator(isAnimating: $output.isLoadingMore, style: .large)
                            Spacer()
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .pullToRefresh(isShowing: self.$output.isReloading) {
                    self.reloadArticlesTrigger.send(())
                }
            }
            .padding(.top)
        }
        .navigationTitle("Catalogs")
        .navigationBarHidden(false)
        .navigationBarItems(trailing:
                                Button(action: {
            
        }, label: {
            Image("filter_icon")
                .resizable()
                .foregroundColor(Color.red)
        })
        )
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            if output.isFirstLoad {
                output.isFirstLoad = false
                loadArticlesTrigger.send(())
            }
            
        }
    }
    
    init(viewModel: ArticlesViewModel) {
        let input = ArticlesViewModel.Input(
            showDetailViewTrigger: showDetailViewTrigger.asDriver(),
            loadArticlesTrigger: loadArticlesTrigger.asDriver(),
            reloadNewsTrigger: reloadArticlesTrigger.asDriver(),
            loadMoreArticlesTrigger: loadMoreArticlesTrigger.asDriver())
        
        output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

#Preview {
    ArticlesView(viewModel: PreviewAssembler().resolve(navigationController: UINavigationController()))
}
