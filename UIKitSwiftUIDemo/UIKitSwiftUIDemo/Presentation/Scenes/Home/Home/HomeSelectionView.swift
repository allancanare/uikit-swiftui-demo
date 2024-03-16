//
//  HomeSelectionView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/09.
//

import SwiftUI

struct HomeSelectionView<ViewModel: HomeSelectionViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List {
            Button {
                viewModel.showViewModel()
            } label: {
                Text("View Model")
            }
            Button {
                viewModel.showSwiftUIKitInterop()
            } label: {
                Text("UIKit SwiftUI Interop")
            }
            Button {
                viewModel.showExampleScreen()
            } label: {
                Text("Example Screens")
            }
        }
    }
}

#Preview {
    HomeSelectionView(viewModel: HomeSelectionViewModel(navigationBarDataSource: NavigationBarDataSource()))
}
