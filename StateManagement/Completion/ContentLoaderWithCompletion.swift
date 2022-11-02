//
//  ContentLoaderWithCompletion.swift
//  StateManagement
//
//  Created by Islom Babaev on 02/11/22.
//

import Foundation

protocol ContentLoaderWithCompletion {
    func loadItems(completion: @escaping ([ContentModel]) -> Void)
}
