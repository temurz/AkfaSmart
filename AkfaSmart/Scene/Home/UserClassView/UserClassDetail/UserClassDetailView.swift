//
//  UserClassDetailView.swift
//  AkfaSmart
//
//  Created by Temur on 29/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct UserClassDetailView: View {
    @ObservedObject var output: ClassDetailViewModel.Output
    private let requestClassDetailsTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            ScrollView {
                if !output.details.isEmpty {
                    ForEach(output.details, id: \.c1Id) { item in
                        ClassDetailViewRow(model: item)
                            .padding()
                            .cornerRadius(12)
                    }
                }
            }
            
        }
        .navigationTitle("My Class")
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            requestClassDetailsTrigger.send(())
        }
    }
    
    init(viewModel: ClassDetailViewModel) {
        let input = ClassDetailViewModel.Input(requestClassDetailsTrigger: requestClassDetailsTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
