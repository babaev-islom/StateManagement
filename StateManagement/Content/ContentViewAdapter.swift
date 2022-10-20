//
//  ContentViewAdapter.swift
//  StateManagement
//
//  Created by Islom Babaev on 14/10/22.
//

import Foundation

@MainActor
final class ContentViewAdapter {
    private let loader: ContentLoader
    private let likeLoader: LikeLoader
    private let viewModel: ContentViewModel
    
    init(
        loader: ContentLoader,
        likeLoader: LikeLoader,
        viewModel: ContentViewModel
    ) {
        self.loader = loader
        self.likeLoader = likeLoader
        self.viewModel = viewModel
    }
    
    func loadData() {
        
        Task { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.didStartLoading()
            
            let items = await self.loader.loadItems()
            let contentViewModelItems = items.map { model in
                let viewModel = LikeViewModel(isLiked: model.isLiked)
                let adapter = LikeAdapter(loader: self.likeLoader, viewModel: viewModel)

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
            
            self.viewModel.didLoad(contentViewModelItems)
        }
//        loader.loadItems { [weak self] items in
//            guard let self = self else { return }
//
//            let contentViewModelItems = items.map { model in
//                let viewModel = ContentSelectionViewModel(isLiked: model.isLiked)
//                let adapter = LikeAdapter(loader: self.likeLoader, viewModel: viewModel)
//
//                let item = ContentItem(
//                        id: model.id,
//                        title: model.title,
//                        isLiked: model.isLiked,
//                        selection: { [adapter] in
//                            adapter.didLikeItem(model: model)
//                        }
//                    )
//
//                return ContentViewModelItem(model: item, viewModel: viewModel)
//            }
//
//            self.viewModel.didLoad(contentViewModelItems)
//        }
    }
}

