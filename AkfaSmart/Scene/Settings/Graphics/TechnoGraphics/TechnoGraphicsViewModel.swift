//
//  TechnoViewModel.swift
//  AkfaSmart
//
//  Created by Даулетбай Комекбаев on 15/02/24.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//


import Foundation
import UIKit
struct TechnoGraphicsViewModel {
    let useCase: TechnoGraphicsViewUseCaseType
    let navigator: TechnographicsNavigatorType
}

extension TechnoGraphicsViewModel: ViewModel {
    struct Input {
        let requestTechnoGraphicsTrigger: Driver<Void>
        let showEditTechnoGraphicsViewTrigger: Driver<Void>
        let openGoogleMapsTrigger: Driver<Location>
    }
    
    final class Output: ObservableObject {
        @Published var isLoading = false
        @Published var alert = AlertMessage()
        @Published var technoGraphics: TechnoGraphics? = nil
        @Published var address = ""
        @Published var addressEdited = ""
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        
        input.requestTechnoGraphicsTrigger
            .map {
                useCase.getTechnoGraphics()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: { technoGraphics in
                output.technoGraphics = technoGraphics
                if let lat = technoGraphics.latitude, let long =  technoGraphics.longitude {
                    ConverterToString.reverseGeocode(latitude: lat, longitude: long) { address in
                        output.address = address
                    }
                }
                
                if let lat = technoGraphics.latitudeEdited, let long =  technoGraphics.longitudeEdited {
                    ConverterToString.reverseGeocode(latitude: lat, longitude: long) { address in
                        output.addressEdited = address
                    }
                }
                
            })
            .store(in: cancelBag)
        
        input.showEditTechnoGraphicsViewTrigger
            .sink {
                if let technoGraphics = output.technoGraphics {
                    navigator.showEditTechnographicsView(model: technoGraphics)
                }
            }
            .store(in: cancelBag)
        
        input.openGoogleMapsTrigger
            .sink { location in
                openGoogleMap(lat: location.latitude, long: location.longitude)
            }
            .store(in: cancelBag)
        
        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0)}
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
    
    func openGoogleMap(lat: Double, long: Double) {
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
            if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
                UIApplication.shared.open(url, options: [:])
            }
        }
        else {
            //Open in browser
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination)
            }
        }
    }
}
