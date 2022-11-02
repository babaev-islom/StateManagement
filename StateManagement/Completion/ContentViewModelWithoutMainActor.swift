//
//  ContentViewModelWithoutMainActor.swift
//  StateManagement
//
//  Created by Islom Babaev on 02/11/22.
//

import Foundation

final class ContentViewModelWithoutMainActor: ObservableObject {
    
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
