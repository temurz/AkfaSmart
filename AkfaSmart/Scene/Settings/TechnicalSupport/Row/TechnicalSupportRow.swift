//
//  TechnicalSupportRow.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 10/03/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct FileItem: Hashable {
    let fileNames: [String]
    let fileURLs: [String]
}

struct Message {
    let isUser: Bool
    let time: String
    let text: String
    var fileItem: FileItem = FileItem(fileNames: [], fileURLs: [])
    
    var filesArray: [SingleFile] {
        var array = [SingleFile]()
        for i in fileItem.fileNames.indices {
            array.append(
                SingleFile(
                name: fileItem.fileNames[i],
                url: fileItem.fileURLs[i]
            )
            )
        }
        return array
    }
}

struct SingleFile {
    let name: String
    let url: String
}

struct MessageViewRow: View {
    var model: Message
    @Binding var isLoadingFile: Bool
    @StateObject var downloadModel = DownloadTaskModel()
    var body: some View {
        
        VStack(alignment: model.isUser ? .trailing : .leading) {
            
            HStack {
                
                if model.isUser {
                    Spacer()
                }
                
                VStack (alignment: model.isUser ? .leading : .trailing) {
                    
                    HStack {
                        if !model.text.isEmpty {
                            Text(model.text)
                                .font(.headline)
                                .foregroundStyle(model.isUser ? .white : .black)
                                .lineLimit(nil)
                                .padding()
                        }
                    }
                        .background(model.isUser ? .red : .white)
                        .cornerRadius(12, corners: model.isUser ?
                                      [.topLeft, .topRight, .bottomLeft] :  [.topRight, .bottomRight , .bottomLeft])
                    if !model.fileItem.fileURLs.isEmpty {
                        ForEach(model.filesArray, id: \.url) { file in
                            Button {
                                downloadModel.startDownload(urlString: file.url)
                                isLoadingFile = true
                            } label: {
                                HStack {
                                    if !model.isUser {
                                        Text(file.name)
                                            .foregroundStyle(.blue)
                                    }
                                    Image(systemName: "folder.fill")
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                        .foregroundStyle(.blue)
                                        .padding()
                                        .background(Color(hex: "#F5F7FA"))
                                        .cornerRadius(8)
                                    if model.isUser {
                                        Text(file.name)
                                            .foregroundStyle(.blue)
                                    }
                                }
                            }
                        }
                    }
                    Text(model.time)
                        .font(.subheadline)
                        .foregroundStyle(Color(hex: "#AEACBC"))  
                }
                
                
                if !model.isUser {
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(model.isUser ? .leading : .trailing)
        .onAppear {
            isLoadingFile = false
        }
    }
    
    private func isImage(_ fileName: String) -> Bool {
        let imageExtensions = ["jpg", "jpeg", "png", "gif", "bmp"] // Add more image extensions if needed
        guard let fileExtension = fileName.components(separatedBy: ".").last else {
            return false
        }
        return imageExtensions.contains(fileExtension.lowercased())
    }
}

#Preview {
    MessageViewRow(model: Message(isUser: true, time: "11.03.2024", text: "Qalay!"), isLoadingFile: .constant(false))
}
