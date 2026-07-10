//
//  LoadableContentView.swift
//  ImageFetcher
//

import SwiftUI

struct LoadableContentView<Value, Content: View>: View {
    let state: ViewState<Value>
    let onRetry: () -> Void
    @ViewBuilder let content: (Value) -> Content

    var body: some View {
        ZStack {
            switch state {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .loaded(let value):
                content(value)

            case .failed(let message):
                ContentUnavailableView {
                    Label("Something Went Wrong", systemImage: "exclamationmark.triangle")
                } description: {
                    Text(message)
                } actions: {
                    Button("Retry", action: onRetry)
                        .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}
