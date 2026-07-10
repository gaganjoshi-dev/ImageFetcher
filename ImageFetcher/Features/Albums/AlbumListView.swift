//
//  AlbumListView.swift
//  ImageFetcher
//

import SwiftUI

struct AlbumListView: View {
    @State private var viewModel = AlbumListViewModel()
    @Environment(AppCoordinator.self) private var coordinator

    var body: some View {
        LoadableContentView(state: viewModel.state, onRetry: retry) { albums in
            List(albums) { album in
                Button {
                    coordinator.showPhotos(for: album)
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(album.displayTitle)
                            .font(.headline)
                            .foregroundStyle(.primary)

                        Text(album.title)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                    .padding(.vertical, 4)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Albums")
        .task { await viewModel.load() }
        .refreshable { await viewModel.load() }
    }

    private func retry() {
        Task { await viewModel.load() }
    }
}

#Preview {
    NavigationStack {
        AlbumListView()
    }
    .environment(AppCoordinator())
}
