//
//  ContentView.swift
//  StateManagement
//
//  Created by Islom Babaev on 13/10/22.
//

import SwiftUI

struct ContentView: View {
#warning("It doubts me to reference two view models at the same time, but I don't want to keep sheet state management in `ContentViewModel`")
    @ObservedObject var viewModel: ContentViewModel
    @ObservedObject var sheetViewModel: SheetPresentingViewModel
    let onViewAppear: () -> Void
    
    var body: some View {
        ZStack {
            Color.black
            
            contentView
            
            if sheetViewModel.isShowingBottomSheet {
                transparentSheet
                    .id(1)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: onViewAppear)
        .id(55)
    }
    
    private var contentView: some View {
        VStack {
            Button {
                withAnimation {
                    sheetViewModel.showSheet()
                }
            } label: {
                Image(systemName: "togglepower")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .padding(.bottom, 20)
            .id(0)
            
            LazyVStack {
                if let state = viewModel.state {
                    switch state {
                    case .loading:
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.white)
                            .frame(width: 48, height: 48)

                    case let .loaded(items):
                        ForEach(items) { item in
                            #warning("It doubts me that `ContentViewModel` knows about `ContentViewModelItem` and as a result about`ContentItem` and `LikeViewModel`")
                            LikeButtonView(item: item.model, viewModel: item.viewModel)
                        }.id(11)
                    }
                }
            }.id(10)
        }
        .opacity(sheetViewModel.isShowingBottomSheet ? 0.25 : 1)
    }
    
    private var transparentSheet: some View {
        Group {
            emptyPlaceholderView
                .id(3)
            
            closeButton
                .id(2)
        }
    }
    
    private var emptyPlaceholderView: some View {
        Color.black.opacity(0.001)
            .onTapGesture {
                withAnimation {
                    sheetViewModel.hideSheet()
                }
            }
    }
    
    private var closeButton: some View {
        Button {
            withAnimation {
                sheetViewModel.hideSheet()
            }
        } label: {
            Image(systemName: "xmark.square.fill")
                .resizable()
                .frame(width: 50, height: 50)
        }
        .padding(.bottom, 50)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewFactory.makeContentview(contentLoader: ContentLoaderStub(), likeLoader: LikeLoaderStub())
    }
}
