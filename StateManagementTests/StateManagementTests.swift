//
//  StateManagementTests.swift
//  StateManagementTests
//
//  Created by Islom Babaev on 27/10/22.
//

import XCTest
@testable import StateManagement
import ViewInspector

extension ContentView: Inspectable {}

extension LikeButtonView: Inspectable {}

@MainActor
final class StateManagementTests: XCTestCase {
    
    func test_showSheet_showsSheetOnButtonTap() throws {
        let sut = makeSUT()

        try sut.showSheet()
                
        XCTAssertTrue(try sut.isShowingSheet())
    }
    
    func test_showSheet_dismissesSheetOnButtonTap() throws {
        let sut = makeSUT()

        try sut.showSheet()
        XCTAssertTrue(try sut.isShowingSheet())
        
        try sut.dismissSheet()
        XCTAssertFalse(try sut.isShowingSheet())
    }
    
    func test_showSheet_dismissesSheetOnEmptyAreaTap() throws {
        let sut = makeSUT()

        try sut.showSheet()
        XCTAssertTrue(try sut.isShowingSheet())
        
        try sut.tapOnEmptyArea()
        XCTAssertFalse(try sut.isShowingSheet())
    }
    
    func test_onAppear_loadsContent() throws {
        let model1 = ContentModel(id: UUID(), title: "a title", isLiked: false)
        let model2 = ContentModel(id: UUID(), title: "a title", isLiked: false)

        let sut = makeSUT(content: [model1, model2])

        try sut.inspect().find(viewWithId: 55).callOnAppear()

        XCTAssertEqual(try sut.inspect().find(viewWithId: 10).underestimatedCount, 2)
    }
    
    private func makeSUT(content: [ContentModel] = []) -> ContentView {
        let contentLoader = ContentStub(models: content)
        return ContentViewFactory.makeContentview(contentLoader: contentLoader, likeLoader: LikeStub())
    }
    
    private class ContentStub: ContentLoader {
        private let models: [ContentModel]
        
        init(models: [ContentModel]) {
            self.models = models
        }
        
        func loadItems() async -> [ContentModel] {
            return models
        }
    }
    
    private class LikeStub: LikeLoader {
        func setModelAsLiked(id: UUID) async throws {}
    }

}

extension ContentView {
    
    func tapOnEmptyArea() throws {
        try inspect().find(viewWithId: 3).callOnTapGesture()
    }
    
    func dismissSheet() throws {
        try inspect().find(viewWithId: 2).button().tap()
    }
    
    func isShowingSheet() throws -> Bool {
        do {
            try transparentSheet()
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult
    private func transparentSheet() throws -> InspectableView<ViewType.ClassifiedView> {
        try inspect().find(viewWithId: 1)
    }
    
    func showSheet() throws {
        try showSheetButton().tap()
    }
    
    private func showSheetButton() throws -> InspectableView<ViewType.Button> {
        try inspect().find(viewWithId: 0).button()
    }
}
