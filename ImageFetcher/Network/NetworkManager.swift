//
//  NetworkManager.swift
//  ImageFetcher
//

import Foundation

protocol NetworkClient: Sendable {
    func fetch<T: Decodable & Sendable>(_ type: T.Type, from url: URL) async throws -> T
}

final class NetworkManager: NetworkClient, @unchecked Sendable {
    static let shared = NetworkManager()

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable & Sendable>(_ type: T.Type, from url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200 ... 299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
