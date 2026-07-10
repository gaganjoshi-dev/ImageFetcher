//
//  PhotoGridView.swift
//  ImageFetcher
//

import SwiftUI

struct PhotoGridView: View {
    @State private var viewModel: PhotoGridViewModel
    @Environment(AppCoordinator.self) private var coordinator

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    init(album: Album) {
        _viewModel = State(initialValue: PhotoGridViewModel(album: album))
    }

    var body: some View {
        LoadableContentView(state: viewModel.state, onRetry: retry) { photos in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(photos) { photo in
                        Button {
                            coordinator.showFullImage(for: photo)
                        } label: {
                            PhotoGridCell(photo: photo)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.album.displayTitle)
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewModel.load() }
        .refreshable { await viewModel.load() }
    }

    private func retry() {
        Task { await viewModel.load() }
    }
}

private struct PhotoGridCell: View {
    let photo: Photo

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RemoteImageView(urlString: photo.thumbnailUrl)
                .frame(height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Text(photo.title)
                .font(.caption)
                .foregroundStyle(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        }
    }
}

#Preview {
    NavigationStack {
        PhotoGridView(album: Album(userId: 1, id: 1, title: "Sample Album"))
    }
    .environment(AppCoordinator())
}
