//
//  Loader.swift
//  StateManagement
//
//  Created by Islom Babaev on 14/10/22.
//

import Foundation

class ContentLoader {
    func loadItems(completion: @escaping ([ContentModel]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion([
                .init(id: UUID(), title: "Text 1", isLiked: false),
                .init(id: UUID(), title: "Text 2", isLiked: false),
                .init(id: UUID(), title: "Text 3", isLiked: true),
                .init(id: UUID(), title: "Text 4", isLiked: true),
            ])
        }
    }
}

extension ContentLoader {
    func loadItems() async -> [ContentModel] {
        await withCheckedContinuation { continuation in
            loadItems { models in
                continuation.resume(with: .success(models))
            }
        }
    }
}
