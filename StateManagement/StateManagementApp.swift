//
//  StateManagementApp.swift
//  StateManagement
//
//  Created by Islom Babaev on 13/10/22.
//

import SwiftUI

//let loader = Loader()
//let likeLoader = LikeLoader()
//let viewModel = ContentViewModel()
//let adapter = Adapter(loader: loader, likeLoader: likeLoader, viewModel: viewModel)

@main
struct StateManagementApp: App {

    var body: some Scene {
        WindowGroup {
        
//            ContentView(viewModel: viewModel, onViewAppear: adapter.loadData)
            ContentViewFactory.makeContentview()
        }
    }
}

class ContentViewFactory {
    private init() {}
    
    @MainActor
    static func makeContentview() -> ContentView {
        let loader = ContentLoader()
        let likeLoader = LikeLoader()
        let viewModel = ContentViewModel()
        let adapter = ContentViewAdapter(loader: loader, likeLoader: likeLoader, viewModel: viewModel)
        return ContentView(
            viewModel: viewModel,
            onViewAppear: {
                adapter.loadData()
            }
        )
    }
}
