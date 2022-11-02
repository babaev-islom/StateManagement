//
//  LikeLoaderWithCompletion.swift
//  StateManagement
//
//  Created by Islom Babaev on 02/11/22.
//

import Foundation

protocol LikeLoaderWithCompletion {
    func setModelAsLiked(id: UUID, completion: @escaping (Result<Void,Error>) -> Void)
}
