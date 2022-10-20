//
//  ContentViewModel.swift
//  StateManagement
//
//  Created by Islom Babaev on 14/10/22.
//

import Foundation

@MainActor
final class ContentViewModel: ObservableObject {
    
    enum State {
        case loading
        case loaded(items: [ContentViewModelItem])
    }
    
    @Published private(set) var state: State?
        
    func didStartLoading() {
        state = .loading
    }
    
    func didLoad(_ items: [ContentViewModelItem]) {
        state = .loaded(items: items)
    }
}
