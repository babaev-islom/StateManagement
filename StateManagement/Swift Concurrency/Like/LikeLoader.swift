//
//  LikeLoader.swift
//  StateManagement
//
//  Created by Islom Babaev on 14/10/22.
//

import Foundation

protocol LikeLoader {
    func setModelAsLiked(id: UUID) async throws
}

class LikeLoaderStub: LikeLoader {
    func setModelAsLiked(id: UUID) async throws {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                continuation.resume(with: .success(()))
            }
        }
    }
}

