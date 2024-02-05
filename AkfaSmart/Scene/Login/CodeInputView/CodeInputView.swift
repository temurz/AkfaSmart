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
    
    @State var statusBarHeight: CGFloat = 0
    @State var username: String = AuthApp.shared.makeStarsInsteadNumbersInUsername()
    @State private var timeRemaining = 120
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
                    
                        Text("One-time code was sent to your phone number \(username) ")
                            .foregroundColor(Color(hex: "#51526C"))
                            .font(.system(size: 17))
                            .padding([.bottom,.horizontal])
                        TextField("SMS code", text: $input.code)
                            .multilineTextAlignment(.center)
                            .frame(height: 48)
                            .background(Color(hex: "#F5F7FA"))
                            .cornerRadius(12)
                            .padding([.top, .horizontal])
                    }
                    HStack {
                        Text("Resend code in:")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#51526C"))
                        Spacer()
                        Text(duration)
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#51526C"))
                    }
                    .padding()
                    Spacer()
                    HStack {
                        Button("Confirm") {
                            confirmRegisterTrigger.send(())
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(12)
                    }
                    .padding()
                    
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
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
            duration = timeRemaining.makeMinutesAndSeconds()
        }
    }
    
    init(viewModel: CodeInputViewModel) {
        let input = CodeInputViewModel.Input(confirmRegisterTrigger: confirmRegisterTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}

struct CodeInputView_Previews: PreviewProvider {
    static var previews: some View {
        let vm: CodeInputViewModel = PreviewAssembler().resolve(navigationController: UINavigationController(), title: "")
        return CodeInputView(viewModel: vm)
    }
    
    
}
