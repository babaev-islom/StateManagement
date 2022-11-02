//
//  LikeAdapter.swift
//  StateManagement
//
//  Created by Islom Babaev on 14/10/22.
//

import Foundation

@MainActor
final class LikeAdapter {
    private let loader: LikeLoader
    private let viewModel: LikeViewModel
    
    init(loader: LikeLoader, viewModel: LikeViewModel) {
        self.loader = loader
        self.viewModel = viewModel
    }
    
    func didLikeItem(model: ContentModel) {
        Task {
            viewModel.didStartLoading()
            do {
                try await loader.setModelAsLiked(id: model.id)
                viewModel.didFinishLikingSuccessfully()
            } catch {
                viewModel.didFinishLikingWithError(error)
            }
        }
    }
}
