//
//  EditInfographicsViewRow.swift
//  AkfaSmart
//
//  Created by Temur on 12/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import UIKit
struct EditInfographicsViewRow: View {
    let title: String
    let constantModel: String?
    @Binding var editedValue: String
    var keyboardType: UIKeyboardType = .default
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal, 4)
            Text(constantModel ?? "")
                .font(.subheadline)
                .padding(.horizontal, 4)
            TextField(editedValue, text: $editedValue)
                .foregroundStyle(.red)
                .frame(height: 48)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 8))
                .background(Color(hex: "#F5F7FA"))
                .cornerRadius(12)
        }
        .padding(.horizontal)
    }
}


struct EditViewRowWithMultiLine: View {
    let title: String
    let constantModel: String?
    @Binding var editedValue: String
    var keyboardType: UIKeyboardType = .default
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal, 4)
            Text(constantModel ?? "")
                .font(.subheadline)
                .padding(.horizontal, 4)
                MultilineTextField(text: $editedValue)
//                    .frame(minWidth: 50, maxWidth: .infinity, minHeight: 50, maxHeight: .infinity)
                .frame(maxWidth: .infinity)
                .frame(height: calculateHeight(text: self.editedValue, width: UIScreen.main.bounds.width))
                    
                    .padding()
                    .background(Color(hex: "#F5F7FA"))
                    .cornerRadius(12)
            
            
        }
        .padding(.horizontal)
    }
    
    private func calculateHeight(text: String, width: CGFloat) -> CGFloat {
           let textHeight = text.height(withConstrainedWidth: width, font: .systemFont(ofSize: 15))
           return textHeight + 10 // No upper limit on height
       }
}

struct MultilineTextField: UIViewRepresentable {
    @Binding var text: String
    var textColor: UIColor = .red
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.text = text
        textView.delegate = context.coordinator
        textView.font = .systemFont(ofSize: 15)
        textView.textColor = textColor
        textView.backgroundColor = .clear
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>

        init(text: Binding<String>) {
            self.text = text
        }

        func textViewDidChange(_ textView: UITextView) {
            text.wrappedValue = textView.text
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            // If return key is pressed, insert a newline character instead of resigning first responder
            if text == "\n" {
                textView.insertText("\n")
                return false
            }
            return true
        }
    }
}


extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}
