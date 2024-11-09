//
//  MainViewModel.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

import UIKit
import Combine

struct MainViewModel {
    let navigator: MainNavigatorType
    let useCase: MainUseCaseType
    let mobileClassUseCase: MobileClassUseCaseType
}

// MARK: - ViewModelType
extension MainViewModel: ViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
        let selectMenuTrigger: Driver<IndexPath>
        let getMobileClassInfo: Driver<Void>
        let showClassDetailViewTrigger: Driver<Void>
        let getGeneralInfoTrigger: Driver<Void>
        let showChatTrigger: Driver<Void>
        let logoutTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var menuSections: [MenuSection] = []
        @Published var mobileClass: MobileClass? = nil
        @Published var mobileClassLogoData: Data? = nil
        @Published var fullname = ""
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        
        input.loadTrigger
            .map {
                self.menuSections()
            }
            .assign(to: \.menuSections, on: output)
            .store(in: cancelBag)
        
        input.selectMenuTrigger
            .handleEvents(receiveOutput: { indexPath in
                let menu = output.menuSections[indexPath.section].menus[indexPath.row]
                switch menu {
                case .products:
                    self.navigator.toProducts()
//                case .sectionedProducts:
//                    self.navigator.toSectionedProducts()
                case .repos:
                    self.navigator.toRepos()
                case .repoCollection:
                    self.navigator.toRepoCollection()
//                case .users:
//                    self.navigator.toUsers()
                case .login:
                    self.navigator.toLogin()
                }
            })
            .sink()
            .store(in: cancelBag)
        
        input.getMobileClassInfo
            .map {
                mobileClassUseCase.getMobileClassInfo()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { mobileClass in
                mobileClassUseCase.getMobileClassImage(mobileClass.logoImgUrl ?? "")
                    .asDriver()
                    .map { data in
                        output.mobileClassLogoData = data
                    }
                    .sink()
                    .store(in: cancelBag)
                output.mobileClass = mobileClass
            })
            .store(in: cancelBag)
        
        input.showClassDetailViewTrigger
            .sink {
                navigator.showClassDetailView(imageData: output.mobileClassLogoData, title: output.mobileClass?.klassName)
            }
            .store(in: cancelBag)
        
        input.getGeneralInfoTrigger
            .sink {
                useCase.getGeneralUserInfo()
                    .asDriver()
                    .sink { info in
                        output.fullname = (info.firstName ?? "") + "\n" + (info.lastName ?? info.middleName ?? "")
                    }
                    .store(in: cancelBag)
            }
            .store(in: cancelBag)
        
        input.showChatTrigger
            .sink {
                navigator.showTechnicalSupport()
            }
            .store(in: cancelBag)
        
        input.logoutTrigger
            .sink {
                AuthApp.shared.token = nil
                AuthApp.shared.username = nil
                AuthApp.shared.pass = nil
                navigator.toLogin()
            }
            .store(in: cancelBag)
                
        return output
    }
    
    private func menuSections() -> [MenuSection] {
        return [
            MenuSection(title: "Mock Data", menus: [.products ]),
            MenuSection(title: "API", menus: [.repos, .repoCollection]),
//            MenuSection(title: "Core Data", menus: [ .users ]),
            MenuSection(title: "", menus: [ .login ])
        ]
    }
}

extension MainViewModel {
    enum Menu: Int, CustomStringConvertible, CaseIterable {
        case products = 0
//        case sectionedProducts = 1
        case repos = 2
        case repoCollection = 3
//        case users = 4
        case login = 5
        
        var description: String {
            switch self {
            case .products:
                return "Product list"
//            case .sectionedProducts:
//                return "Sectioned product list"
            case .repos:
                return "Git repo list"
            case .repoCollection:
                return "Git repo collection"
//            case .users:
//                return "User list"
            case .login:
                return "Login"
            }
        }
    }
    
    struct MenuSection {
        let title: String
        let menus: [Menu]
    }
}
