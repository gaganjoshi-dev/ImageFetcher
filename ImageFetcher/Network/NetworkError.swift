//
//  NetworkError.swift
//  ImageFetcher
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid request."
        case .decodingFailed:
            return "Could not read the response. Please try again."
        }
    }
}
