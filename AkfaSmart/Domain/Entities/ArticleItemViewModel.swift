//
//  ArticleItemViewModel.swift
//  AkfaSmart
//
//  Created by Temur on 05/02/2024.
//  Copyright © 2024 Tuan Truong. All rights reserved.
//

import Foundation

struct ArticleItemViewModel: Codable, Identifiable {
    let id: Int
    let date: Int?
    let title: String?
    let shortContent: String?
    let htmlContent: String?
    let imageUrl: String?
    let type: String?
    let buttonColor: String?
    let fileUrls: [FileUrls]
}

struct FileUrls: Codable {
    let name: String?
    let url: String?
}

struct ArticleType:Decodable, Hashable, Identifiable {
    let id: Int?
    let name: String?
    let parentId: Int?
    let parentName: Int?
    let hasChild: Bool?
}
