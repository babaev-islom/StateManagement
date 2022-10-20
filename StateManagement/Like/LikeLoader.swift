//
//  LikeLoader.swift
//  StateManagement
//
//  Created by Islom Babaev on 14/10/22.
//

import Foundation

class LikeLoader {
    func setModelAsLiked(id: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(()))
        }
    }
}

extension LikeLoader {
    func setModelAsLiked(id: UUID) async throws {
        try await withCheckedThrowingContinuation { continuation in
            setModelAsLiked(id: id) { result in
                continuation.resume(with: result)
            }
        }
    }
}

