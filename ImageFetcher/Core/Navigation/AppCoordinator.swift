//
//  AppCoordinator.swift
//  ImageFetcher
//

import SwiftUI

@MainActor
@Observable
final class AppCoordinator {
    var navigationPath = NavigationPath()
    var selectedPhoto: Photo?
    var isShowingFullImage = false

    func showPhotos(for album: Album) {
        navigationPath.append(Route.photos(album: album))
    }

    func showFullImage(for photo: Photo) {
        selectedPhoto = photo
        isShowingFullImage = true
    }

    func dismissFullImage() {
        isShowingFullImage = false
        selectedPhoto = nil
    }
}
