//
//  ContentViewAdapterWithCompletion.swift
//  StateManagement
//
//  Created by Islom Babaev on 02/11/22.
//

import Foundation

final class ContentViewAdapterWithCompletion {
    private let loader: ContentLoaderWithCompletion
    private let likeLoader: LikeLoaderWithCompletion
    private let viewModel: ContentViewModelWithoutMainActor
    
    init(
        loader: ContentLoaderWithCompletion,
        likeLoader: LikeLoaderWithCompletion,
        viewModel: ContentViewModelWithoutMainActor
    ) {
        self.loader = loader
        self.likeLoader = likeLoader
        self.viewModel = viewModel
    }
    
    func loadData() {
        viewModel.didStartLoading()
        
        loader.loadItems { [viewModel, likeLoader] items in
            let contentViewModelItems = items.map { model in
                let viewModel = LikeViewModel(isLiked: model.isLiked)
                let adapter = LikeAdapterWithCompletion(loader: likeLoader, viewModel: viewModel)
                
                let item = ContentItem(
                    id: model.id,
                    title: model.title,
                    isLiked: model.isLiked,
                    selection: { [adapter] in
                        adapter.didLikeItem(model: model)
                    }
                )
                
                return ContentViewModelItem(model: item, viewModel: viewModel)
            }
            
            if Thread.isMainThread {
                viewModel.didLoad(contentViewModelItems)

            } else {
                DispatchQueue.main.async {
                    viewModel.didLoad(contentViewModelItems)
                }
            }

        }
    }
}
