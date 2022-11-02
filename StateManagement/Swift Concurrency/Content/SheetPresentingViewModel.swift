//
//  SheetPresentingViewModel.swift
//  StateManagement
//
//  Created by Islom Babaev on 25/10/22.
//

import Foundation

final class SheetPresentingViewModel: ObservableObject {
    @Published private(set) var isShowingBottomSheet = false
    
    func showSheet() {
        isShowingBottomSheet = true
    }
    
    func hideSheet() {
        isShowingBottomSheet = false
    }
}
