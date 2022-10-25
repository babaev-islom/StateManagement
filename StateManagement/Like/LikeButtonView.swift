//
//  LikeButtonView.swift
//  StateManagement
//
//  Created by Islom Babaev on 14/10/22.
//

import SwiftUI

struct LikeButtonView: View {
    let item: ContentItem
    @ObservedObject var viewModel: LikeViewModel
    
    var body: some View {
        HStack {
            Text(item.title)
                .foregroundColor(.white)
            
            Spacer()
            
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                        .frame(width: 48, height: 48)
                } else {
                    Button {
                        item.selection()
                    } label: {
                        Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 48, height: 48)
                    }
                }
                
            }
            
        }
    }
}
