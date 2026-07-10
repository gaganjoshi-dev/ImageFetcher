//
//  RemoteImageView.swift
//  ImageFetcher
//

import SwiftUI

struct RemoteImageView: View {
    let urlString: String?

    var body: some View {
        if let url = RemotePhotoURL.resolvedURL(from: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    placeholder
                @unknown default:
                    placeholder
                }
            }
        } else {
            placeholder
        }
    }

    private var placeholder: some View {
        Image(systemName: "photo")
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.secondarySystemBackground))
    }
}
