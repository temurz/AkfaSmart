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
    private let cancelBag = CancelBag()
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack() {
                List {
                    ForEach(output.articles) { article in
                        Button(action: {
                            showDetailViewTrigger.send(article)
                        }) {
                            ArticleRow(viewModel: article)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .pullToRefresh(isShowing: self.$output.isReloading) {
                    
                }
                
            }
            
            .padding(.top)
        }
        .navigationTitle("Catalogs")
        .navigationBarItems(trailing: 
                                Button(action: {
            
        }, label: {
            Image(systemName: "slider.horizontal.3")
                .resizable()
                .foregroundColor(Color.red)
        })
            //slider.horizontal.3
        )
    }
    
    init(viewModel: ArticlesViewModel) {
        let input = ArticlesViewModel.Input(showDetailViewTrigger: showDetailViewTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

#Preview {
    ArticlesView(viewModel: PreviewAssembler().resolve(navigationController: UINavigationController()))
}
