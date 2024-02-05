//
//  NewsView.swift
//  AkfaSmart
//
//  Created by Temur on 01/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import SwiftUIRefresh
import Combine
struct NewsView: View {
    @ObservedObject var output: NewsViewModel.Output
    private let selectNewsTrigger = PassthroughSubject<NewsItemViewModel, Never>()
    private let cancelBag = CancelBag()
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack() {
                List {
                    ForEach(output.news) { news in
                        Button(action: {
                            self.selectNewsTrigger.send(news)
                        }) {
                                NewsTableRow(viewModel: news)
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
        .navigationTitle("News")
        
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear(perform: {
        })

    }
    
    init(viewModel: NewsViewModel) {
        let input = NewsViewModel.Input(selectEventTrigger: selectNewsTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        
    }
}

struct NewsView_Preview: PreviewProvider {
    static var previews: some View {
        let vm: NewsViewModel = PreviewAssembler().resolve(navigationController: UINavigationController())
        return NewsView(viewModel: vm)
    }
}
