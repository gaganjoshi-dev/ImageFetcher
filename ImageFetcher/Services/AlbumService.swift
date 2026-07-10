//
//  AlbumService.swift
//  ImageFetcher
//

import Foundation

protocol AlbumServiceProtocol: Sendable {
    func fetchAlbums() async throws -> [Album]
}

final class AlbumService: AlbumServiceProtocol, @unchecked Sendable {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient = NetworkManager.shared) {
        self.networkClient = networkClient
    }

    func fetchAlbums() async throws -> [Album] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/albums") else {
            throw NetworkError.invalidURL
        }

        return try await networkClient.fetch([Album].self, from: url)
    }
}
