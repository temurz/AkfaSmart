//
//  ImageDownloaderGateway.swift
//  AkfaSmart
//
//  Created by Temur on 26/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation
protocol ImageDownloaderGatewayType {
    func downloadImage(_ urlString: String) -> Observable<Data>
}

struct ImageDownloaderGateway: ImageDownloaderGatewayType {
    func downloadImage(_ urlString: String) -> Observable<Data> {
        let input = API.GetImageInput(urlString)
        return API.shared.getUserClassImage(input)
    }
}
