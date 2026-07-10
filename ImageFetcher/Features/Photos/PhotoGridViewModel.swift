//
//  PhotoGridViewModel.swift
//  ImageFetcher
//

import Foundation

@MainActor
@Observable
final class PhotoGridViewModel {
    let album: Album
    private(set) var state: ViewState<[Photo]> = .loading

    private let photoService: PhotoServiceProtocol

    init(album: Album, photoService: PhotoServiceProtocol = PhotoService()) {
        self.album = album
        self.photoService = photoService
    }

    func load() async {
        state = .loading

        do {
            let photos = try await photoService.fetchPhotos(albumId: album.id)
            state = .loaded(photos)
        } catch {
            state = .failed(message: error.localizedDescription)
        }
    }
}
