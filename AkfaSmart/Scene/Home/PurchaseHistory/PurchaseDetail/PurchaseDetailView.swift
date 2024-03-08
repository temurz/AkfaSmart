//
//  PurchaseDetailView.swift
//  AkfaSmart
//
//  Created by Temur on 08/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct PurchaseDetailView: View {
    var model: Invoice
    @ObservedObject var output: PurchaseDetailViewModel.Output
    private let loadDetailsTrigger = PassthroughSubject<InvoiceDetailViewInput, Never>()
    private let cancelBag = CancelBag()

    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                List {
                    ForEach(output.items, id: \.uniqueId) { item in
                        PurchaseDetailViewRow(model: item)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("\(model.cid ?? 0)")
        .onAppear {
            loadDetailsTrigger.send(InvoiceDetailViewInput(invoiceId: model.cid ?? 0, dealerId: model.dealerId ?? 0))
        }
    }
    
    init(model: Invoice, viewModel: PurchaseDetailViewModel) {
        self.model = model
        let input = PurchaseDetailViewModel.Input(loadDetailsTrigger: loadDetailsTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

