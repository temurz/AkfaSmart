//
//  NewsItemViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation

struct NewsItemViewModel: Codable, Identifiable {
    let id: Int
    let date: Int?
    let title: String?
    let shortContent: String?
    let htmlContent: String?
    let imageUrl: String?
}
