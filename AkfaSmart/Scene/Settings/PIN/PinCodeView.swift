//
//  PinCodeView.swift
//  AkfaSmart
//
//  Created by Temur on 19/03/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct PINCodeView: View {
    @ObservedObject var output: PINCodeViewModel.Output
    private let sendCodeTrigger = PassthroughSubject<Void, Never>()
    private let skipTrigger = PassthroughSubject<Void, Never>()
    private let cancelBag = CancelBag()
    
    

    @State var id = UUID()
    @FocusState var focusField: FocusField?
    enum FocusField {
        case first
        case second
    }
    var body: some View {
        VStack {
            Spacer()
            Text(output.state.rawValue.localizedString)
                .multilineTextAlignment(.center)
            ZStack {
                HStack(spacing: 8) {
                    SingleCodeView(filled: $output.firstLetterFilled)
                    SingleCodeView(filled: $output.secondLetterFilled)
                    SingleCodeView(filled: $output.thirdLetterFilled)
                    SingleCodeView(filled: $output.fourthLetterFilled)
                }
                TextField("", text: $output.code)
                    .foregroundStyle(.clear)
                    .background(.clear)
                    .keyboardType(.numberPad)
                    .accentColor(.clear)
                    .id(id)
                    .focused($focusField, equals: .first)
                    .onChange(of: output.code) { newValue in
                        switch newValue.count {
                        case 0:
                            output.firstLetterFilled = false
                            output.validationMessage = ""
                        case 1:
                            output.firstLetterFilled = true
                            output.secondLetterFilled = false
                            output.thirdLetterFilled = false
                            output.fourthLetterFilled = false
                            output.validationMessage = ""
                        case 2:
                            output.secondLetterFilled = true
                            output.thirdLetterFilled = false
                            output.fourthLetterFilled = false
                            output.validationMessage = ""
                        case 3:
                            output.thirdLetterFilled = true
                            output.fourthLetterFilled = false
                            output.validationMessage = ""
                        case 4:
                            output.fourthLetterFilled = true
                            sendCodeTrigger.send(())
                        default:
                            output.code.removeLast()
                        }
                    }
            }
            if !output.validationMessage.isEmpty {
                Text(output.validationMessage)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.red)
                    .padding(4)
            }
            Spacer()
            if output.state == .onAuth {
                Button() {
                    skipTrigger.send(())
                    AuthApp.shared.appEnterCode = nil
                } label: {
                    Text("SKIP".localizedString)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(Color.blue)
                        .padding()
                }
            }
        }
        .navigationTitle("PIN_CODE_VIEW_TITLE".localizedString)
        .toastView(toast: $output.toast)
        .onAppear {
            focusField = FocusField.first
        }
    }
    
    init(viewModel: PINCodeViewModel) {
        let input = PINCodeViewModel.Input(saveCodeTrigger: sendCodeTrigger.asDriver(),
                                           skipTrigger: skipTrigger.asDriver())
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}


