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
    
    private let cancelBag = CancelBag()
    private let confirmRegisterTrigger = PassthroughSubject<Void,Never>()
    private let resendSMSTrigger = PassthroughSubject<Void,Never>()
    private let showMainView = PassthroughSubject<Void,Never>()
    
    @State var statusBarHeight: CGFloat = 0
    @State var username: String = AuthApp.shared.username?.makeStarsInsteadNumbersInUsername() ?? ""
//    @State private var timeRemaining = 120
    @State var duration = "2:00"
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            ZStack {
                Color.red
                    .ignoresSafeArea(edges: .top)
                Color.white
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .padding(.top, statusBarHeight > 0 ? statusBarHeight : 48)
                    .ignoresSafeArea()
                    .onAppear {
                        if let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager {
                            statusBarHeight = statusBarManager.statusBarFrame.height
                        }
                    }
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Image("akfa_smart")
                            .frame(width: 124, height: 44)
                        Spacer()
                    }
                    .ignoresSafeArea()
                    .padding(.bottom)
                    VStack(alignment: .leading, spacing: 16) {
                        Text(output.title)
                            .font(.title)
                            .padding(.horizontal)
                    
                        Text("CODE_SENT_TO_PHONE".localizedString + "\(output.username) ")
                            .foregroundColor(Color(hex: "#51526C"))
                            .font(.system(size: 17))
                            .padding([.bottom,.horizontal])
                        TextField("SMS_CODE".localizedString, text: $input.code)
                            .multilineTextAlignment(.center)
                            .frame(height: 48)
                            .background(Color(hex: "#F5F7FA"))
                            .cornerRadius(12)
                            .padding([.top, .horizontal])
                        Text(output.codeValidationMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.horizontal)
                    }
                    HStack {
                        Text("RESEND_CODE_IN".localizedString)
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#51526C"))
                        Spacer()
                        Text(duration)
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#51526C"))
                            .onTapGesture {
                                if output.timeRemaining == 0 {
                                    resendSMSTrigger.send(())
                                }
                            }
                    }
                    .padding()
                    Spacer()
                    HStack {
                        Button {
                            confirmRegisterTrigger.send(())
                        } label: {
                            Text("CONFIRM".localizedString)
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
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
            }
        }
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
                duration = "RESEND_SMS".localizedString
            }
        }
    }
    
    init(viewModel: CodeInputViewModel) {
        let input = CodeInputViewModel.Input(
            confirmRegisterTrigger: confirmRegisterTrigger.asDriver(),
            resendSMSTrigger: resendSMSTrigger.asDriver(),
            showMainViewTrigger: showMainView.asDriver()
        )
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}

struct CodeInputView_Previews: PreviewProvider {
    static var previews: some View {
        let vm: CodeInputViewModel = PreviewAssembler().resolve(navigationController: UINavigationController(), reason: .register)
        return CodeInputView(viewModel: vm)
    }
}
