//
//  TechnicalSupportView.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 10/03/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct TechnicalSupportView: View {
    @ObservedObject var output: TechnicalSupportViewModel.Output
    @State private var messageText = ""

    private let getMessagesTrigger = PassthroughSubject<Void,Never>()
    private let loadMoreMessagesTrigger = PassthroughSubject<Void, Never>()
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                List(output.items, id: \.self) { item in
                    MessageViewRow(model: Message(isUser: item.userId == nil , time: item.date ?? "", text: item.text ?? ""))
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
                .background(Color(hex: "#EAEEF5"))
                .listStyle(.plain)

                HStack {
                    TextField("Написать", text: $messageText)
                        .padding(.leading, 8)
                        .frame(height: 40)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                    Button(action: {
                        
                        print("Sending message: \(messageText)")
                        self.messageText = ""
                        
                    }) {
                        
                        Image(systemName: "paperplane")
                            .foregroundColor(.blue)
                            .padding(.trailing, 8)
                    }
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(10)
            }
            .background(Color(hex: "#EAEEF5"))
        }
        .navigationTitle("Chat")
        .alert(isPresented: $output.alert.isShowing, content: {
            Alert(title: Text(output.alert.title),
                  message: Text(output.alert.message),
                  dismissButton: .default(Text("OK"))
            )
        })
        .refreshable {
            if output.hasMorePages {
                loadMoreMessagesTrigger.send(())
            }
        }
        .onAppear {
            getMessagesTrigger.send(())
        }
    }
    
    
    init(viewModel: TechnicalSupportViewModel) {
        let input = TechnicalSupportViewModel.Input(
            loadMessagesTrigger: getMessagesTrigger.asDriver(),
            reloadMessagesTrigger: Driver.empty(),
            loadMoreMessagesTrigger: loadMoreMessagesTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
    
}
