//
//  ContentViewAdapter.swift
//  StateManagement
//
//  Created by Islom Babaev on 14/10/22.
//

import Foundation

#warning("Making an adapter to be @MainActor runs every task on a serial main queue and I don't want to block it")
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

#warning("Using a detached task would not inherit actor isolation, but creation and calling view model methods still need to be run on main actor. I'm not willing to dispatch onto main actor in every do-catch branch since it leads to messy code. I love how we dispatched to main queue with the decorator in the program, but couldn't figure out the way how to do it with swift concurrency")
        
#warning("I do know that task creation is non-blocking and would cause a thread hop. However, test would not pass and would complete immediately. Is there a way to test it via expectation or something else?")
        Task { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.didStartLoading()
            
            let items = await self.loader.loadItems()

            #warning("Since `LikeAdapter` is @MainActor and `ContentViewAdapter` is also a main actor, it can create it without awaiting inside a task. However, we need to await or create main actor inside MainActor.run block. Is this an okay behavior?")
            
            #warning("If I remove @MainActor on this adapter, I can't create `LikeAdapter` inside the loop with await")

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

