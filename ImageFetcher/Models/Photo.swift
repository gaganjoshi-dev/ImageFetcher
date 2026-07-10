//
//  Photo.swift
//  ImageFetcher
//

import Foundation

struct Photo: Codable, Identifiable, Hashable, Sendable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String

    enum CodingKeys: String, CodingKey {
        case albumId = "albumId"
        case id, title, url
        case thumbnailUrl = "thumbnailUrl"
    }
}
