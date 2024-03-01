//
//  ProductOwnersListView.swift
//  AkfaSmart
//
//  Created by Temur on 01/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct ProductDealersListView: View {
    var model: ProductWithName
    @ObservedObject var output: ProductDealersListViewModel.Output
    
    private let loadProductDealersTrigger = PassthroughSubject<ProductDealersListInput, Never>()
    private let reloadProductDealersTrigger = PassthroughSubject<ProductDealersListInput, Never>()
    private let loadMoreProductDealersTrigger = PassthroughSubject<ProductDealersListInput, Never>()
    private let cancelBag = CancelBag()
    
    var body: some View {
        return LoadingView(isShowing: .constant(false), text: .constant("")) {
            VStack {
                VStack(alignment: .leading) {
                    Text(model.name)
                        .font(.subheadline)
                        .foregroundColor(Color(hex: "#9497A1"))
                    HStack(spacing: 0) {
                        Text("Guruh: ")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "#9497A1"))
                        Spacer()
                        Text(model.groupName)
                    }
                    
                    HStack {
                        Text("Narxi: ")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "#9497A1"))
                        Spacer()
                        Text(model.rate.convertDecimals() + " uzs")
                    }
                }
                .padding()
                
                List {
                    ForEach(output.items, id: \.dealerId) { item in
                        ProductDealerViewRow(model: item)
                            .padding(.vertical, 4)
                            .listRowSeparator(.hidden)
                    }
                }
                .background(Color(hex: "#EAEEF5"))
                .listStyle(.plain)
            }
        }
        .navigationTitle("Ushbu mahsulot bor bo'lgan dilerlar")
        .onAppear {
            loadProductDealersTrigger.send(ProductDealersListInput(productName: "Poliamid PVC002 (6.52m) (Tr)", latitude: 51.759247, longitude: 19.455982))
        }
    }
    
    init(model: ProductWithName, viewModel: ProductDealersListViewModel) {
        self.model = model
        let input = ProductDealersListViewModel.Input(loadProductDealersTrigger: loadProductDealersTrigger.asDriver(), reloadProductDealersTrigger: reloadProductDealersTrigger.asDriver(), loadMoreProductDealersTrigger: loadMoreProductDealersTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
