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
    var imageData: Data?
    var classTitle: String?
    private let requestClassDetailsTrigger = PassthroughSubject<Void,Never>()
    private let popViewControllerTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                CustomNavigationBar(title: "MY_CLASS".localizedString) {
                    popViewControllerTrigger.send(())
                }
                ScrollView {
                    ZStack {
                        Color(hex: "#E9E9E9")
                            .frame(height: 7)
                        Image(data: imageData ?? Data())?
                            .resizable()
                            .frame(width: 70, height: 70)
                            .padding()
                    }
                   
                    Text(classTitle ?? "")
                        .font(.title)
                        
                    if !output.details.isEmpty {
                        ForEach(output.details, id: \.c1Id) { item in
                            ClassDetailViewRow(model: item)
                                .padding(4)
                                .cornerRadius(12)
                        }
                    }
                }
            }
        }
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
    
    init(viewModel: ClassDetailViewModel, _ imageData: Data?, title: String?) {
        self.imageData = imageData
        self.classTitle = title
        let input = ClassDetailViewModel.Input(
            requestClassDetailsTrigger: requestClassDetailsTrigger.asDriver(),
            popViewControllerTrigger: popViewControllerTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}
