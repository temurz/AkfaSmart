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
        let showPINCodeViewTrigger: Driver<Int>
        let loadInitialSettings: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var items = [
            [
                SettingItemViewModel(id: 0, image: "person", text: "PERSONAL_DATA".localizedString),
                SettingItemViewModel(id: 1, image: "", text: "INFOGRAPHICS".localizedString),
                SettingItemViewModel(id: 2, image: "", text: "TECHNOGRAPHICS".localizedString),
                SettingItemViewModel(id: 3, image: "", text: "HR_GRAPHICS".localizedString),
                SettingItemViewModel(id: 4, image: "", text: "MARKET_GRAPHICS".localizedString),
                SettingItemViewModel(id: 5, image: "", text: "PRODUCT_GRAPHICS".localizedString),
            ],
            [
                SettingItemViewModel(id: 6, image: "headset_mic", text: "TECHNICAL_SUPPORT".localizedString),
                SettingItemViewModel(id: 7, image: "lock", text: "PIN_CODE".localizedString),
                SettingItemViewModel(id: 8, image: "translate", text: "LANGUAGE".localizedString)
            ]
        ]
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var user: GeneralUser? = nil
        @Published var imageData: Data? = nil
        @Published var showImageSourceSelector = false
        @Published var showPinCodeOptionSelector = false
        @Published var hasPIN = false
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
                navigator.showTechnicalSupport()
            case 7:
                output.showPinCodeOptionSelector = true
            case 8:
                navigator.showLanguageChanger()
            default:
                break
            }
            
        }
        .store(in: cancelBag)
        
        input.showPINCodeViewTrigger.sink { tag in
            switch tag {
            case 0:
                navigator.showPINCodeView(state: .createNew)
            case 1:
                navigator.showPINCodeView(state: .oldPin)
            default:
                navigator.showPINCodeView(state: .createNew)
            }
        }
        .store(in: cancelBag)
        
        input.loadInitialSettings
            .sink {
                output.hasPIN = AuthApp.shared.appEnterCode != nil
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
