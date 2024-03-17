//
//  ViewModelSelectionView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/09.
//

import SwiftUI

struct ViewModelSelectionView<ViewModel: ViewModelSelectionViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List {
            Button {
                viewModel.showSolutionA()
            } label: {
                Text("Solution A")
            }
            Button {
                viewModel.showSolutionB()
            } label: {
                Text("Solution B")
            }
            Button {
                viewModel.showSolutionC()
            } label: {
                Text("Solution C")
            }
        }
    }
}

#Preview {
    ViewModelSelectionView(viewModel: ViewModelSelectionViewModel(navigationBarDataSource: NavigationBarDataSource()))
}
