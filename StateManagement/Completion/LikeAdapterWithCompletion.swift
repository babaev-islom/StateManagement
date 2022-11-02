//
//  LikeAdapterWithCompletion.swift
//  StateManagement
//
//  Created by Islom Babaev on 02/11/22.
//

import Foundation

final class LikeAdapterWithCompletion {
    private let loader: LikeLoaderWithCompletion
    private let viewModel: LikeViewModel
    
    init(loader: LikeLoaderWithCompletion, viewModel: LikeViewModel) {
        self.loader = loader
        self.viewModel = viewModel
    }
    
    func didLikeItem(model: ContentModel) {
        viewModel.didStartLoading()
        loader.setModelAsLiked(id: model.id) { [viewModel] result in
            switch result {
            case .success:
                viewModel.didFinishLikingSuccessfully()
            case let .failure(error):
                viewModel.didFinishLikingWithError(error)

            }
        }
    }
}
