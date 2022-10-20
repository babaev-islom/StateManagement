//
//  LikeViewModel.swift
//  StateManagement
//
//  Created by Islom Babaev on 14/10/22.
//

import Foundation

final class LikeViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published private(set) var isLiked: Bool
    
    init(isLiked: Bool) {
        self.isLiked = isLiked
    }

    func didStartLoading() {
        isLoading = true
    }
    
    func didFinishLikingSuccessfully() {
        isLoading = false
        isLiked = true
    }
    
    func didFinishLikingWithError(_ error: Error) {
        isLoading = false
        isLiked = false
    }
}
