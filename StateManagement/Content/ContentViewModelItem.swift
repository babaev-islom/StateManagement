//
//  ContentViewModelItem.swift
//  StateManagement
//
//  Created by Islom Babaev on 14/10/22.
//

import Foundation

struct ContentViewModelItem: Identifiable {
    var id: UUID { model.id }
    let model: ContentItem
    let viewModel: LikeViewModel
}
