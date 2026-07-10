//
//  AlbumListViewModel.swift
//  ImageFetcher
//

import Foundation

@MainActor
@Observable
final class AlbumListViewModel {
    private(set) var state: ViewState<[Album]> = .loading

    private let albumService: AlbumServiceProtocol

    init(albumService: AlbumServiceProtocol = AlbumService()) {
        self.albumService = albumService
    }

    func load() async {
        state = .loading

        do {
            let albums = try await albumService.fetchAlbums()
            state = .loaded(albums)
        } catch {
            state = .failed(message: error.localizedDescription)
        }
    }
}
