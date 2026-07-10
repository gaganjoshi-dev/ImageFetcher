//
//  RootView.swift
//  ImageFetcher
//

import SwiftUI

struct RootView: View {
    @State private var coordinator = AppCoordinator()

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            AlbumListView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .photos(let album):
                        PhotoGridView(album: album)
                    }
                }
        }
        .environment(coordinator)
        .sheet(isPresented: Binding(
            get: { coordinator.isShowingFullImage },
            set: { isPresented in
                if !isPresented {
                    coordinator.dismissFullImage()
                }
            }
        )) {
            if let photo = coordinator.selectedPhoto {
                FullImageView(photo: photo)
            }
        }
    }
}

#Preview {
    RootView()
}
