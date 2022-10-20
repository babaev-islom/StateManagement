//
//  ContentItem.swift
//  StateManagement
//
//  Created by Islom Babaev on 14/10/22.
//

import Foundation

struct ContentItem: Identifiable {
    let id: UUID
    let title: String
    let isLiked: Bool
    let selection: () -> Void
}
