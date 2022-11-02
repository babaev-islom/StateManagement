//
//  ContentViewFactoryWithCompletion.swift
//  StateManagement
//
//  Created by Islom Babaev on 02/11/22.
//

import Foundation

final class ContentViewFactoryWithCompletion {
    private init() {}
    
    static func makeContentView(contentLoader: ContentLoaderWithCompletion, likeLoader: LikeLoaderWithCompletion) -> ContentViewWithoutMainActor {
        let viewModel = ContentViewModelWithoutMainActor()
        let sheetViewModel = SheetPresentingViewModel()
        let adapter = ContentViewAdapterWithCompletion(loader: contentLoader, likeLoader: likeLoader, viewModel: viewModel)
        return ContentViewWithoutMainActor(
            viewModel: viewModel,
            sheetViewModel: sheetViewModel,
            onViewAppear: {
                adapter.loadData()
            }
        )
    }
}
