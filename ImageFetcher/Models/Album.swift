//
//  Album.swift
//  ImageFetcher
//

import Foundation

struct Album: Codable, Identifiable, Hashable, Sendable {
    let userId: Int
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id, title
    }

    var displayTitle: String {
        "Album \(id)"
    }
}
