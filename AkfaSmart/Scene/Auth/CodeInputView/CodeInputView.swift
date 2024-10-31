//
//  CodeInputView.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct CodeInputView: View {
    @ObservedObject var input: CodeInputViewModel.Input
    @ObservedObject var output: CodeInputViewModel.Output
    @Environment(\.dismiss) var dismiss
    private let cancelBag = CancelBag()
    private let confirmRegisterTrigger = PassthroughSubject<Void,Never>()
    private let resendSMSTrigger = PassthroughSubject<Void,Never>()
    private let showMainView = PassthroughSubject<Void,Never>()
    private let confirmActiveUserTrigger = PassthroughSubject<Void,Never>()
    private let popViewControllerTrigger = PassthroughSubject<Void,Never>()
    
    @State var username: String = AuthApp.shared.username?.makeStarsInsteadNumbersInUsername() ?? ""
//    @State private var timeRemaining = 120
    @State var duration = "2:00"
    
    let isModal: Bool
    var completion: ((Bool) -> Void)?
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            VStack {
                if !isModal {
                    CustomNavigationBar(title: "") {
                        popViewControllerTrigger.send(())
                    }
                }
                ZStack {
                    VStack(alignment: .leading) {
                        if !isModal {
                            HStack {
                                Spacer()
                                Image("akfa_smart")
                                    .frame(width: 124, height: 44)
                                Spacer()
                            }
                            .ignoresSafeArea()
                            .padding(.bottom)
                        }else {
                            ZStack {
                                Text(output.title)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding()
                                HStack {
                                    Spacer()
                                    Button {
                                        completion?(output.success)
                                        dismiss()
                                    } label: {
                                        Image("cancel")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .padding()
                                    }
                                }
                            }
                            
                        }
                        VStack(alignment: .leading, spacing: 16) {
                            if !isModal {
                                Text(output.title)
                                    .font(.title)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.horizontal)
                            }
                            
                            
                            Text(String(format: NSLocalizedString("CODE_SENT_TO_PHONE".localizedString, comment: ""), output.username)
                            )
                            .foregroundColor(Colors.textDescriptionColor)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.bottom)
                            VStack(spacing: 0) {
                                TextField("SMS_CODE".localizedString, text: $input.code)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.numberPad)
                                    .frame(height: 50)
                                    .background(Colors.textFieldMediumGrayBackground)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(
                                                self.output.codeValidationMessage.isEmpty ? Colors.borderGrayColor : .red,
                                                lineWidth: self.output.codeValidationMessage.isEmpty ? 1 : 2)
                                    }
                                    .padding(.top)
                                    .onChange(of: input.code) { newValue in
                                        output.isConfirmEnabled = !newValue.isEmpty
                                    }
                                Text(output.codeValidationMessage)
                                    .foregroundColor(.red)
                                    .font(.footnote)
                                    .padding(.horizontal)
                                Text(duration)
                                    .font(.system(size: 14))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .foregroundColor(Colors.textSteelColor)
                            }
                        }
                        Spacer()
                        if duration.isEmpty {
                            HStack {
                                Spacer()
                                Button {
                                    if output.timeRemaining == 0 {
                                        resendSMSTrigger.send(())
                                    }
                                } label: {
                                    Text("RESEND_SMS".localizedString)
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(Colors.customRedColor)
                                        
                                }
                                Spacer()
                            }
                         
                        }
                        Button {
                            confirmRegisterTrigger.send(())
                        } label: {
                            Text("CONFIRM".localizedString)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .foregroundColor(.white)
                                .background(!input.code.isEmpty && output.timeRemaining > 0 ? Colors.customRedColor : .gray)
                                .cornerRadius(8)
                        }
                        .allowsHitTesting(output.isConfirmEnabled && output.timeRemaining > 0)
                        
                        switch output.reason {
                        case .dealer:
                            Button() {
                                showMainView.send(())
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("SKIP".localizedString)
                                        .font(.system(size: 16))
                                        .frame(height: 32)
                                        .foregroundColor(Color.blue)
                                    Spacer()
                                }
                                
                            }
                        default:
                            EmptyView()
                        }
                    }
                    .padding()
                    confirmActiveDealerView
                }
            }
        }
        .onChange(of: output.success, perform: { newValue in
            if newValue {
                completion?(newValue)
                dismiss()
            }
        })
        .alert(isPresented: $output.alert.isShowing) {
            Alert(
                title: Text(output.alert.title),
                message: Text(output.alert.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .onReceive(timer) { time in
            if output.timeRemaining > 0 {
                output.timeRemaining -= 1
                duration = output.timeRemaining.makeMinutesAndSeconds()
            }else {
                duration = ""
                
            }
        }
    }
    
    var confirmActiveDealerView: some View {
        ZStack {
            if output.showConfirmAlert {
                Color.black.opacity(0.6).ignoresSafeArea(.all)
                VStack {
                    Text(String(format: NSLocalizedString("REACTIVATE_DEALER_ALERT_TEXT".localizedString, comment: ""), output.activeUsername?.removeWhitespacesFromString().makeStarsInsteadNumbersInUsername() ?? "***"))
                        .multilineTextAlignment(.center)
                        .padding()
                    HStack(spacing: 12) {
                        Button {
                            output.showConfirmAlert = false
                        } label: {
                            Text("DISMISS".localizedString)
                                .foregroundStyle(.red)
                                .background(.clear)
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 0.5)
                                }
                                .padding()
                        }
                        Button {
                            confirmActiveUserTrigger.send(())
                            output.showConfirmAlert = false
                        } label: {
                            Text("ADD".localizedString)
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .cornerRadius(12)
                                .padding()
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)

            }
        }
    }
    
    init(viewModel: CodeInputViewModel, isModal: Bool = false, completion: ((Bool) -> Void)? = nil) {
        let input = CodeInputViewModel.Input(
            confirmRegisterTrigger: confirmRegisterTrigger.asDriver(),
            resendSMSTrigger: resendSMSTrigger.asDriver(),
            showMainViewTrigger: showMainView.asDriver(),
            confirmActiveUserTrigger: confirmActiveUserTrigger.asDriver(),
            popViewControllerTrigger: popViewControllerTrigger.asDriver()
        )
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
        self.isModal = isModal
        self.completion = completion
    }
}

struct CodeInputView_Previews: PreviewProvider {
    static var previews: some View {
        let vm: CodeInputViewModel = PreviewAssembler().resolve(navigationController: UINavigationController(), reason: .register)
        return CodeInputView(viewModel: vm)
    }
}
