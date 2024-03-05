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
    private let editAvatarImageTrigger = PassthroughSubject<Void, Never>()
    private let getGeneralUserInfoTrigger = PassthroughSubject<Void,Never>()
    private let selectRowTrigger = PassthroughSubject<Int,Never>()
    private let deleteAccountTrigger = PassthroughSubject<Void, Never>()
    
    
    let cancelBag = CancelBag()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                headerView
                    .padding()
                
                Color(hex: "#E2E5ED").frame(height: 4)
                ForEach(output.items[0]) { item in
                    SettingsRowView(viewModel: item)
                        .onTapGesture {
                            selectRowTrigger.send(item.id)
                        }
                }
                    
                Color(hex: "#E2E5ED").frame(height: 4)
                ForEach(output.items[1]) { item in
                    SettingsRowView(viewModel: item)
                        .onTapGesture {
                            selectRowTrigger.send(item.id)
                        }
                    Divider()
                }
                
                Button("Delete account") {
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
        .navigationTitle("Settings")
        .navigationBarHidden(false)
    }
    
    init(viewModel: SettingsViewModel) {
        let input = SettingsViewModel.Input(selectRowTrigger: selectRowTrigger.asDriver(), deleteAccountTrigger: deleteAccountTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
    }
    
    var headerView: some View {
        HStack {
            ZStack {
                if output.user != nil, let url = output.user?.imageUrl {
                    EmptyView()
                        .frame(width: 80, height: 80)
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
            .frame(height: 94)
            
            VStack(alignment: .leading) {
                Text("\(output.user?.firstName ?? "") + \(output.user?.middleName ?? "") + \(output.user?.lastName ?? "")")
                    .font(.headline)
                Text(output.user?.username ?? "")
                    .font(.footnote)
                    .foregroundColor(.red)
                Spacer()
//                Text("Identified")
//                    .foregroundColor(.white)
//                    .font(.footnote)
//                    .padding(.horizontal, 6)
//                    .padding(.vertical, 2)
//                    .background(Color(hex: "#5DB075"))
//                    .cornerRadius(12.5)
            }
            .frame(height: 80)
            .padding(.horizontal)
        }
    }
}

struct SettingsView_Preview: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
