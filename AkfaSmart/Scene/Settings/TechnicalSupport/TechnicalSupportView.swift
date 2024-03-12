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
    private let clearHistoryTrigger = PassthroughSubject<Void,Never>()
    private let sendMessageTrigger = PassthroughSubject<String,Never>()
    private let cancelBag = CancelBag()
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                if output.items.isEmpty && !output.isLoading {
                    VStack {
                        Spacer()
                        Text("CHAT_IS_EMPTY".localizedString)
                            .foregroundStyle(Color.gray)
                        Spacer()
                    }
                    
                }else {
                    ScrollViewReader { proxy in
                        VStack {
                            ScrollView(.vertical) {
                                VStack {
                                    ForEach(output.items, id: \.self) { item in
                                        MessageViewRow(model:
                                                        Message(isUser: item.userId == nil , time: item.date ?? "", text: item.text ?? "")
                                        )
                                    }
                                }.id("ScrollView")
                            }
                            .onChange(of: output.items) { _ in
                                if output.isFirstLoad {
                                    output.isFirstLoad = false
                                    withAnimation {
                                        proxy.scrollTo("ScrollView", anchor: .bottom)
                                    }
                                }
                            }
                            .onChange(of: output.newMessages) { _ in
                                withAnimation {
                                    proxy.scrollTo("ScrollView", anchor: .bottom)
                                }
                            }
                        }
                    }
                }
                Spacer()
                HStack {
                    TextField("TEXT".localizedString, text: $messageText)
                        .padding(.leading, 8)
                        .frame(height: 40)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                    Button(action: {
                        if !messageText.isEmpty {
                            sendMessageTrigger.send(messageText)
                            self.messageText = ""
                        }
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
        .navigationTitle("CHAT".localizedString)
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
        .navigationBarItems(trailing:
                                Menu {
            Button {
                clearHistoryTrigger.send(())
            } label: {
                Text("CLEAR".localizedString)
            }

        } label: {
            Image("more")
                .resizable()
                .frame(width: 20, height: 20)
        }
        )
    }
    
    
    init(viewModel: TechnicalSupportViewModel) {
        let input = TechnicalSupportViewModel.Input(
            loadMessagesTrigger: getMessagesTrigger.asDriver(),
            reloadMessagesTrigger: Driver.empty(),
            loadMoreMessagesTrigger: loadMoreMessagesTrigger.asDriver(),
            clearHistoryTrigger: clearHistoryTrigger.asDriver(),
            sendMessageTrigger: sendMessageTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
    
}
