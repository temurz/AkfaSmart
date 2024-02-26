//
//  ImageDownloaderViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 26/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ImageDownloaderUseCaseType {
    func downloadImage(_ urlString: String) -> Observable<Data>
}
struct ImageDownloaderUseCase: ImageDownloaderUseCaseType, ImageDownloaderDomainUseCase {
    var gateway: ImageDownloaderGatewayType
}


struct ImageDownloaderViewModel {
    let useCase: ImageDownloaderUseCaseType = ImageDownloaderUseCase(gateway: ImageDownloaderGateway())
}

extension ImageDownloaderViewModel: ViewModel {
    struct Input {
        let getImageTrigger: Driver<String>
    }
    
    final class Output: ObservableObject {
        @Published var imageData: Data? = nil
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.getImageTrigger
            .map { url in
            useCase.downloadImage(url)
                .asDriver()
        }
        .switchToLatest()
        .sink(receiveValue: { data in
            output.imageData = data
        })
        .store(in: cancelBag)
        return output
    }
}
