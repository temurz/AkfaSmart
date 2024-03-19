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
    private let sendMessageWithImageTrigger = PassthroughSubject<MessageWithData, Never>()
    private let cancelBag = CancelBag()
    @State var showImagePicker = false
    let documentPickerDelegate = DocumentPickerDelegate()
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
                                                        Message(isUser: item.userId == nil , time: item.date ?? "", text: item.text ?? "",
                                                                fileItem: item.fileItems)
                                                       ,
                                                       isLoadingFile: $output.isLoadingFile
                                                    
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
                    ZStack(alignment: .leading) {
                        TextField("TEXT".localizedString, text: $messageText)
                            .padding(.horizontal, 40)
                            .frame(height: 40)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        Button {
                            showImagePicker = true
//                            showDocumentPicker()
                        } label: {
                            Image("attach_file")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding(.leading, 8)
                        }
                    }
                    

                    Button(action: {
                        if !messageText.isEmpty {
                            sendMessageTrigger.send(messageText)
                            self.messageText = ""
                        }
                    }) {
                        
                        Image("send")
                            .foregroundColor(.red)
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
        .overlay {
            if output.isLoadingFile {
                ProgressView()
                    .controlSize(.large)
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $output.selectedImageData) {
                sendMessageWithImageTrigger.send(MessageWithData(text: messageText, data: output.selectedImageData))
                messageText = ""
            }
            .ignoresSafeArea(.all)
        }
        .onAppear {
            output.isLoadingFile = false
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
    
    func showDocumentPicker() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data"], in: .import)
                    documentPicker.delegate = documentPickerDelegate // Assign the delegate
                    UIApplication.shared.windows.first?.rootViewController?.present(documentPicker, animated: true, completion: nil)
    }
    
    
    init(viewModel: TechnicalSupportViewModel) {
        let input = TechnicalSupportViewModel.Input(
            loadMessagesTrigger: getMessagesTrigger.asDriver(),
            reloadMessagesTrigger: Driver.empty(),
            loadMoreMessagesTrigger: loadMoreMessagesTrigger.asDriver(),
            clearHistoryTrigger: clearHistoryTrigger.asDriver(),
            sendMessageTrigger: sendMessageTrigger.asDriver(),
            sendMessageWithImageTrigger: sendMessageWithImageTrigger.asDriver()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
    
}

class DocumentPickerDelegate: NSObject, UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        if let fileData = dataFromFile(at: selectedFileURL) {
            // Now you have the file data, you can send it to the server
            print("File data: \(fileData)")
        } else {
            print("Failed to read data from file.")
        }
    }
    
    func dataFromFile(at url: URL) -> Data? {
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("Error reading data from file: \(error.localizedDescription)")
            return nil
        }
    }
}
