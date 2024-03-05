//
//  SettingsViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
struct SettingItemViewModel: Identifiable {
    let id: Int
    let image: String
    let text: String
    let isToggle: Bool = false
}
struct SettingsViewModel {
    let navigator: SettingsNavigatorType
    let useCase: SettingsUseCaseType
    let downloadImageUseCase: ImageDownloaderUseCaseType
}

extension SettingsViewModel: ViewModel {
    struct Input {
        let selectRowTrigger: Driver<Int>
        let deleteAccountTrigger: Driver<Void>
        let loadUserInfoTrigger: Driver<Void>
        let uploadAvatarImageTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var items = [
            [
                SettingItemViewModel(id: 0, image: "person", text: "Personal data"),
                SettingItemViewModel(id: 1, image: "", text: "Infographics"),
                SettingItemViewModel(id: 2, image: "", text: "Technographics"),
                SettingItemViewModel(id: 3, image: "", text: "HR graphics"),
                SettingItemViewModel(id: 4, image: "", text: "Market graphics"),
                SettingItemViewModel(id: 5, image: "", text: "Product graphics"),
            ],
            [
                SettingItemViewModel(id: 6, image: "headset_mic", text: "Technical support"),
                SettingItemViewModel(id: 7, image: "lock", text: "PIN-code"),
                SettingItemViewModel(id: 8, image: "translate", text: "Language")
            ]
        ]
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var user: GeneralUser? = nil
        @Published var imageData: Data? = nil
        @Published var showImageSourceSelector = false
        @Published var showImagePicker = false
        @Published var imageChooserType: PickerImage.Source = .library
        @Published var oldImageData: Data? = nil
        @Published var isFirstLoad = true
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.deleteAccountTrigger.sink { _ in
            AuthApp.shared.token = nil
            AuthApp.shared.username = nil
            navigator.showLogin()
        }
        .store(in: cancelBag)
        
        input.selectRowTrigger.sink { id in
            switch id {
            case 1:
                navigator.showInfographics()
            case 2:
                navigator.showTechnographics()
            case 3:
                navigator.showHRgraphics()
            case 4:
                navigator.showMarketinggraphics()
            case 5:
                navigator.showProductGraphics()
            case 6:
                break
            case 7:
                break
            case 8:
                navigator.showLanguageChanger()
            default:
                break
            }
            
        }
        .store(in: cancelBag)
        
        input.loadUserInfoTrigger
            .map {
                useCase.getGeneralUserInfo()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { user in
                output.user = user
                if let imageURL = user.imageUrl {
                    downloadImageUseCase.downloadImage(imageURL)
                        .asDriver()
                        .sink { data in
                            output.imageData = data
                            output.oldImageData = data
                        }
                        .store(in: cancelBag)
                }
            })
            .store(in: cancelBag)
        
        input.uploadAvatarImageTrigger
            .sink {
                useCase.setAvatarImage(data: output.imageData ?? Data())
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
                    .sink { bool in
                        if !bool {
                            output.imageData = output.oldImageData
                        }
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0 ) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
