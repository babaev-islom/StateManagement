//
//  Loader.swift
//  StateManagement
//
//  Created by Islom Babaev on 14/10/22.
//

import Foundation

protocol ContentLoader {
    func loadItems() async -> [ContentModel]
}

class ContentLoaderStub: ContentLoader {
    func loadItems() async -> [ContentModel] {
        await withCheckedContinuation { continuation in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                continuation.resume(with: .success([
                    ContentModel(id: UUID(), title: "Text 1", isLiked: false),
                    ContentModel(id: UUID(), title: "Text 2", isLiked: false),
                    ContentModel(id: UUID(), title: "Text 3", isLiked: true),
                    ContentModel(id: UUID(), title: "Text 4", isLiked: true),
                ]))
            }
        }
    }
}
