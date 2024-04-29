//
//  SettingsView.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import SwiftUI
import Combine
import PhotosUI
struct SettingsView: View {
    @ObservedObject var output: SettingsViewModel.Output
    private let loadInitialSettings = PassthroughSubject<Void, Never>()
    private let uploadAvatarImageTrigger = PassthroughSubject<Void, Never>()
    private let getGeneralUserInfoTrigger = PassthroughSubject<Void,Never>()
    
    private let selectRowTrigger = PassthroughSubject<Int,Never>()
    private let deleteAccountTrigger = PassthroughSubject<Void, Never>()
    private let showPINCodeViewTrigger = PassthroughSubject<Int, Never>()
    private let cancelBag = CancelBag()
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        headerView
                            .padding()
                        
                        Color(hex: "#E2E5ED").frame(height: 4)
                        ForEach(output.items[0]) { item in
                            SettingsRowView(viewModel: item)
                                .background(Color.white)
                                .onTapGesture {
                                    selectRowTrigger.send(item.id)
                                }
                        }
                        
                        Color(hex: "#E2E5ED").frame(height: 4)
                        ForEach(output.items[1]) { item in
                            SettingsRowView(viewModel: item)
                                .background(Color.white)
                                .onTapGesture {
                                    selectRowTrigger.send(item.id)
                                }
                            Divider()
                        }
                        
                        Button("DELETE_ACCOUNT".localizedString) {
                            deleteAccountTrigger.send(())
                        }
                        .foregroundColor(Color.red)
                        .font(.bold(.headline)())
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .overlay {
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.red, lineWidth: 1.5)
                        }
                        .padding(24)
                    }
                }
                imageSourceSelector
                pinCodeOptionSelector
            }
            .navigationTitle("SETTINGS_TITLE".localizedString)
            .navigationBarHidden(false)
            .alert(isPresented: $output.alert.isShowing) {
                Alert(
                    title: Text(output.alert.title),
                    message: Text(output.alert.message),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onAppear {
                loadInitialSettings.send(())
                if output.imageData == nil {
                    if output.isFirstLoad {
                        output.isFirstLoad = false
                        getGeneralUserInfoTrigger.send(())
                    }
                }
            }
            .refreshable {
                loadInitialSettings.send(())
                getGeneralUserInfoTrigger.send(())
            }
            .sheet(isPresented: $output.showImagePicker) {
                ImagePicker(sourceType: output.imageChooserType == .library ? .photoLibrary : .camera, selectedImage: $output.imageData) {
                    uploadAvatarImageTrigger.send(())
                    output.showImageSourceSelector = false
                }
                    .ignoresSafeArea()
            }
        }
    }
    
    init(viewModel: SettingsViewModel) {
        let input = SettingsViewModel.Input(
            selectRowTrigger: selectRowTrigger.asDriver(),
            deleteAccountTrigger: deleteAccountTrigger.asDriver(),
            loadUserInfoTrigger: getGeneralUserInfoTrigger.asDriver(),
            uploadAvatarImageTrigger: uploadAvatarImageTrigger.asDriver(),
            showPINCodeViewTrigger: showPINCodeViewTrigger.asDriver(),
            loadInitialSettings: loadInitialSettings.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
    }
    
    var headerView: some View {
        HStack {
            ZStack {
                if output.imageData != nil, let data = output.imageData {
                    Image(data: data)?
                        .resizable()
                        .background(Color(hex: "#DFE3EB"))
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                }else {
                    Image("avatar")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .background(Color(hex: "#DFE3EB"))
                        .cornerRadius(8)
                }
                VStack {
                    Spacer()
                    Button {
                        output.showImageSourceSelector.toggle()
                    } label: {
                        Image("pen")
                            .resizable()
                            .frame(width: 12, height: 12)
                    }
                    .frame(width: 28, height: 28)
                    .background(Color(hex: "#DFE3EB"))
                    .cornerRadius(14)
                    .offset(CGSize(width: 1, height: 10))
                }
                
            }
            .frame(width: 80, height: 94)
            
            VStack(alignment: .leading) {
                Text("\(output.user?.firstName ?? "") \(output.user?.middleName ?? "") \(output.user?.lastName ?? "")")
                    .font(.headline)
                Text(output.user?.username?.formatPhoneNumber() ?? "")
                    .font(.footnote)
                    .foregroundColor(.red)
                Spacer()
            }
            .frame(height: 80)
            .padding(.horizontal)
            
        }
    }
    
    var imageSourceSelector: some View {
        ZStack {
            if output.showImageSourceSelector {
                Color.black.opacity(0.6).ignoresSafeArea(.all)
                VStack(spacing: 0) {
                    Spacer()
                    Button {
                        if !PickerImage.checkPermissions(.library) {
                            return
                        }
                        output.imageChooserType = .library
                        output.showImagePicker = true
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "folder.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color(hex: "#51526C"))
                            Text("USE_GALLERY".localizedString)
                                .bold()
                                .foregroundColor(Color(hex: "#51526C"))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color(hex: "#DFE3EB"))
                        .cornerRadius(12)
                        .padding()
                    }
                    
                    Button {
                        if !PickerImage.checkPermissions(.camera) {
                            
                            return
                        }
                        output.imageChooserType = .camera
                        output.showImagePicker = true
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color(hex: "#51526C"))
                            Text("USE_CAMERA".localizedString)
                                .bold()
                                .foregroundColor(Color(hex: "#51526C"))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color(hex: "#DFE3EB"))
                        .cornerRadius(12)
                        .padding()
                    }
                    
                    Button {
                        output.showImageSourceSelector = false
                    } label: {
                        Text("CLOSE".localizedString)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .foregroundColor(Color.white)
                            .background(Color.red)
                            .cornerRadius(12)
                            .padding()
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 240)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
            }
        }
    }
    
    var pinCodeOptionSelector: some View {
        ZStack {
            if output.showPinCodeOptionSelector {
                Color.black.opacity(0.6).ignoresSafeArea(.all)
                VStack(spacing: 0) {
                    Spacer()
                    Button {
                        output.showPinCodeOptionSelector = false
                        showPINCodeViewTrigger.send(0)
                    } label: {
                        HStack(spacing: 8) {
                            Text("CREATE_NEW_PIN".localizedString)
                                .bold()
                                .foregroundColor(Color(hex: "#51526C"))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(Color(hex: "#DFE3EB"))
                        .cornerRadius(12)
                        .padding()
                    }
                    if output.hasPIN {
                        Button {
                            showPINCodeViewTrigger.send(1)
                            output.showPinCodeOptionSelector = false
                        } label: {
                            HStack(spacing: 8) {
                                Text("REMOVE_PIN".localizedString)
                                    .bold()
                                    .foregroundColor(Color(hex: "#51526C"))
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(Color(hex: "#DFE3EB"))
                            .cornerRadius(12)
                            .padding()
                        }
                    }
                    
                    Button {
                        output.showPinCodeOptionSelector = false
                    } label: {
                        Text("CLOSE".localizedString)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .foregroundColor(Color.white)
                            .background(Color.red)
                            .cornerRadius(12)
                            .padding()
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: output.hasPIN ? 240 : 160)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
            }
        }
    }
}

struct SettingsView_Preview: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
