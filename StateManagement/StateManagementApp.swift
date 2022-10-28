//
//  StateManagementApp.swift
//  StateManagement
//
//  Created by Islom Babaev on 13/10/22.
//

import SwiftUI

@main
struct StateManagementApp: App {

    var body: some Scene {
        WindowGroup {
            ContentViewFactory.makeContentview(
                contentLoader: ContentLoaderStub(),
                likeLoader: LikeLoaderStub()
            )
        }
    }
}

class ContentViewFactory {
    private init() {}
    
    @MainActor
    static func makeContentview(contentLoader: ContentLoader, likeLoader: LikeLoader) -> ContentView {
        let viewModel = ContentViewModel()
        let sheetViewModel =  SheetPresentingViewModel()
        let adapter = ContentViewAdapter(loader: contentLoader, likeLoader: likeLoader, viewModel: viewModel)
        return ContentView(
            viewModel: viewModel,
            sheetViewModel: sheetViewModel, 
            onViewAppear: {
                adapter.loadData()
            }
        )
    }
}
