//
//  ContentUIIntegrationTests.swift
//  StateManagementTests
//
//  Created by Islom Babaev on 29/10/22.
//

import Foundation
@testable import StateManagement
import XCTest
import SwiftUI
import ViewInspector

extension ContentViewWithoutMainActor: Inspectable {}

class ContentViewFactory2Tests: XCTestCase {
    func test_onAppear_loadsListOfModels() throws {
        let model0 = ContentModel(id: UUID(), title: "a title", isLiked: true)
        let model1 = ContentModel(id: UUID(), title: "another title", isLiked: false)
        let contentSpy = ContentLoaderSpy()
        let likeSpy = LikeLoaderSpy()
        let sut = ContentViewFactoryWithCompletion.makeContentView(contentLoader: contentSpy, likeLoader: likeSpy)
        
        try sut.inspect().find(viewWithId: 55).callOnAppear()
        
        contentSpy.completeContentLoading(with: [model0, model1])

        let list = try sut.inspect().find(viewWithId: 11).forEach()
        XCTAssertEqual(list.underestimatedCount, 2)
    }
    
    private class ContentLoaderSpy: ContentLoaderWithCompletion {
        private var completions = [(([ContentModel]) -> Void)]()
        
        func loadItems(completion: @escaping ([ContentModel]) -> Void) {
            completions.append(completion)
        }
        
        func completeContentLoading(with items: [ContentModel], at index: Int = 0) {
            completions[index](items)
        }
    }
    
    private class LikeLoaderSpy: LikeLoaderWithCompletion {
        private var completions = [((Result<Void, Error>) -> Void)]()

        func setModelAsLiked(id: UUID, completion: @escaping (Result<Void, Error>) -> Void) {
            completions.append(completion)
        }
        
        func completeLikingSuccessfully(at index: Int = 0) {
            completions[index](.success(()))
        }
        
        func completeLiking(with error: NSError, at index: Int = 0) {
            let anyNSError = NSError(domain: "test", code: 0)
            completions[index](.failure(anyNSError))
        }
    }
}
