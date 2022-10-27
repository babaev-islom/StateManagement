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
            ContentViewFactory.makeContentview()
        }
    }
}

class ContentViewFactory {
    private init() {}
    
    @MainActor
    static func makeContentview() -> ContentView {
        let loader = ContentLoaderStub()
        let likeLoader = LikeLoaderStub()
        let viewModel = ContentViewModel()
        let sheetViewModel =  SheetPresentingViewModel()
        let adapter = ContentViewAdapter(loader: loader, likeLoader: likeLoader, viewModel: viewModel)
        return ContentView(
            viewModel: viewModel,
            sheetViewModel: sheetViewModel, 
            onViewAppear: {
                adapter.loadData()
            }
        )
    }
}
