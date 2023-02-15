//
//  BooksModel.swift
//  APIBooks
//
//  Created by raul.santos on 09/02/23.
//

import Foundation
import UIKit


struct BooksResponse: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable {
    let title: String
    let publisher: String?
    let imageLinks: ImageLinks
}

struct ImageLinks: Codable {
    let thumbnail: String
    
}

