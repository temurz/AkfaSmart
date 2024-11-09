//
//  MainView.swift
//  AkfaSmart
//
//  Created by Temur on 30/01/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
struct MainView: View {
    @ObservedObject var viewRouter: MainViewRouter
    @ObservedObject var output: MainViewModel.Output
    @State var showSideMenu = false
   
    private let getMobileClassInfoTrigger = PassthroughSubject<Void,Never>()
    private let showClassDetailViewTrigger = PassthroughSubject<Void,Never>()
    private let getGeneralInfoTrigger = PassthroughSubject<Void,Never>()
    private var showSettingsTrigger = PassthroughSubject<Void,Never>()
    private let showChatTrigger = PassthroughSubject<Void,Never>()
    private let logoutTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 0) {
                viewRouter.body
                    .frame(maxHeight: .infinity)
                TabBarView(viewRouter: viewRouter, prominentItemImageName: "") {
                    
                }
                .frame(width: geometry.size.width, height: geometry.size.height/10)
                .background(Color("tabBarColor").shadow(radius: 2))
                
            }
            if showSideMenu {
                ZStack(alignment: .leading) {
                    Color.black
                        .opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showSideMenu = false
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            }
            if showSideMenu {
                ZStack(alignment: .leading) {
                    SideMenu(
                        username: $output.fullname,
                        model: $output.mobileClass,
                        imageData: $output.mobileClassLogoData,
                        showClassDetailTrigger: showClassDetailViewTrigger,
                        showChatTrigger: showChatTrigger,
                        logoutTrigger: logoutTrigger,
                        showSettingsAction: {
                            self.showSideMenu = false
                            viewRouter.route(selectedPageId: MainPage.settings.rawValue)
                        })
                        .background(.white)
                        .frame(maxHeight: .infinity)
                }
                .frame(width: UIScreen.main.bounds.width/1.25)
                .frame(maxHeight: .infinity, alignment: .leading)
                .ignoresSafeArea()
                .transition(.move(edge: .leading))
                
            }
        }
        .onAppear(perform: {
            getMobileClassInfoTrigger.send(())
            getGeneralInfoTrigger.send(())
            viewRouter.showSideMenu = {
                withAnimation(.easeInOut) {
                    showSideMenu = true
                }
            }
        })
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
        
    }
    
    init(viewRouter: MainViewRouter, viewModel: MainViewModel) {
        self.viewRouter = viewRouter
        let input = MainViewModel.Input(
            loadTrigger: Driver.empty(),
            selectMenuTrigger: Driver.empty(),
            getMobileClassInfo: getMobileClassInfoTrigger.asDriver(),
            showClassDetailViewTrigger: showClassDetailViewTrigger.asDriver(),
            getGeneralInfoTrigger: getGeneralInfoTrigger.asDriver(),
            showChatTrigger: showChatTrigger.asDriver(),
            logoutTrigger: logoutTrigger.asDriver()
        )
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}


struct SideMenu: View {
    @Binding var username: String
    @Binding var model: MobileClass?
    @Binding var imageData: Data?
    
    var showClassDetailTrigger: PassthroughSubject<Void,Never>
    var showChatTrigger: PassthroughSubject<Void,Never>
    var logoutTrigger: PassthroughSubject<Void,Never>
    
    var showSettingsAction: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(username)
                .bold()
                .font(.title)
            UserClassView(model: $model, imageData: $imageData)
                .frame(height: 86)
                .onTapGesture {
                    showClassDetailTrigger.send(())
                }
            VStack {
                Button {
                    showSettingsAction?()
                } label: {
                    HStack {
                        Image("settings_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        Text("SETTINGS_TITLE".localizedString)
                            .foregroundStyle(Colors.textSteelColor)
                        Spacer()
                    }
                    .padding(.vertical)
                }

                Button {
                    showChatTrigger.send(())
                } label: {
                    HStack {
                        Image("headphone")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        Text("TEXT_TO_SUPPORT".localizedString)
                            .foregroundStyle(Colors.textSteelColor)
                        Spacer()
                    }
                    .padding(.vertical)
                }
            }
            Spacer()
           

            HStack {
                Button {
                    logoutTrigger.send(())
                } label: {
                    Image("logout")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    Text("LOGOUT".localizedString)
                        .foregroundStyle(Colors.primaryTextColor)
                }
                Spacer()
                Text(String(format: NSLocalizedString("VERSION".localizedString, comment: ""), "2.1.1"))
                    .font(.footnote)
                    .foregroundStyle(Colors.textSteelColor)
            }
            
        }
        .padding()
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
        .frame(height: UIScreen.main.bounds.height)
    }
}
