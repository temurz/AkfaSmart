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
    let loadArticlesTrigger = PassthroughSubject<ArticlesGetInput, Never>()
    let reloadArticlesTrigger = PassthroughSubject<ArticlesGetInput,Never>()
    let loadMoreArticlesTrigger = PassthroughSubject<ArticlesGetInput,Never>()
    let showFilterViewTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                ModuleNavigationBar(title: "ARTICLES".localizedString, rightBarTitle: "FILTER".localizedString) {
                    showFilterViewTrigger.send(())
                }
                if output.articles.isEmpty && !output.isLoading {
                    VStack(alignment: .center) {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("LIST_IS_EMPTY".localizedString)
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                        Spacer()
                    }
                }else {
                    List {
                        ForEach(output.articles) { article in
                            Button(action: {
                                showDetailViewTrigger.send(article)
                            }) {
                                ArticleRow(itemModel: article)
                                    .onAppear {
                                        if output.articles.last?.id ?? -1 == article.id && output.hasMorePages {
                                            output.isLoadingMore = true
                                            let input = ArticlesGetInput(
                                                from: output.dateFilter.optionalFrom,
                                                to: output.dateFilter.optionalTo,
                                                type: output.articleType.type, name: output.articleType.name)
                                            
                                            self.loadMoreArticlesTrigger.send(input )
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
                    .refreshable {
                        let input = ArticlesGetInput(
                            from: output.dateFilter.optionalFrom,
                            to: output.dateFilter.optionalTo,
                            type: output.articleType.type,
                            name: output.articleType.name)
                        self.reloadArticlesTrigger.send(input)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            if output.isFirstLoad || output.dateFilter.isFiltered {
                output.isFirstLoad = false
                output.articles = []
                let input = ArticlesGetInput(
                    from: output.dateFilter.optionalFrom,
                    to: output.dateFilter.optionalTo,
                    type: output.articleType.type,
                    name: output.articleType.name)
                loadArticlesTrigger.send(input)
            }
        }
    }
    
    init(viewModel: ArticlesViewModel) {
        let input = ArticlesViewModel.Input(
            showDetailViewTrigger: showDetailViewTrigger.asDriver(),
            loadArticlesTrigger: loadArticlesTrigger.asDriver(),
            reloadArticlesTrigger: reloadArticlesTrigger.asDriver(),
            loadMoreArticlesTrigger: loadMoreArticlesTrigger.asDriver(),
            showFilterViewTrigger: showFilterViewTrigger.asDriver())
        
        output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

#Preview {
    ArticlesView(viewModel: PreviewAssembler().resolve(navigationController: UINavigationController()))
}

struct ArticlesGetInput {
    let from: Date?
    let to: Date?
    let type: String?
    let name: String?
}
