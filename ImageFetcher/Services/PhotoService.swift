//
//  PhotoService.swift
//  ImageFetcher
//

import Foundation

protocol PhotoServiceProtocol: Sendable {
    func fetchPhotos(albumId: Int) async throws -> [Photo]
}

final class PhotoService: PhotoServiceProtocol, @unchecked Sendable {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient = NetworkManager.shared) {
        self.networkClient = networkClient
    }

    func fetchPhotos(albumId: Int) async throws -> [Photo] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)") else {
            throw NetworkError.invalidURL
        }

        return try await networkClient.fetch([Photo].self, from: url)
    }
}
