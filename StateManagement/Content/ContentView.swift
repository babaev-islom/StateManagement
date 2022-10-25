//
//  ContentView.swift
//  StateManagement
//
//  Created by Islom Babaev on 13/10/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    let onViewAppear: () -> Void
    
    var body: some View {
        LazyVStack {
            if let state = viewModel.state {
                switch state {
                case .loading:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .foregroundColor(.green)
                
                case let .loaded(items):
                    ForEach(items) { item in
                        #warning("It doubts me that `ContentViewModel` knows about `ContentViewModelItem` and as a result about`ContentItem` and `LikeViewModel`")
                        LikeButtonView(item: item.model, viewModel: item.viewModel)
                    }
                }
            }
        }
        .onAppear(perform: onViewAppear)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewFactory.makeContentview()
    }
}
