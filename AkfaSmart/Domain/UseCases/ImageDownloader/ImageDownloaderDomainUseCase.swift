//
//  ImageDownloaderDomainUseCase.swift
//  AkfaSmart
//
//  Created by Temur on 26/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ImageDownloaderDomainUseCase {
    var gateway: ImageDownloaderGatewayType { get }
}

extension ImageDownloaderDomainUseCase {
    func downloadImage(_ urlString: String) -> Observable<Data> {
        gateway.downloadImage(urlString)
    }
}
