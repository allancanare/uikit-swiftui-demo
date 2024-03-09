//
//  HomeSelectionView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/09.
//

import SwiftUI

protocol HomeSelectionViewDelegate {
    func homeSelectionViewWillShowViewModel()
    func homeSelectionViewWillShowSwiftUIKitInterop()
}

struct HomeSelectionView: View {
    var delegate: HomeSelectionViewDelegate?
    
    var body: some View {
        List {
            Button {
                delegate?.homeSelectionViewWillShowViewModel()
            } label: {
                Text("View Model")
            }
            Button {
                delegate?.homeSelectionViewWillShowSwiftUIKitInterop()
            } label: {
                Text("UIKit SwiftUI Interop")
            }
        }
    }
}

#Preview {
    HomeSelectionView()
}
