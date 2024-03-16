//
//  FrameworkSelectionView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/09.
//

import SwiftUI

struct FrameworkSelectionView<ViewModel: FrameworkSelectionViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List {
            Button {
                viewModel.showUIKit()
            } label: {
                Text("UIKit")
            }
            Button {
                viewModel.showSwiftUI()
            } label: {
                Text("SwiftUI")
            }
        }
    }
}

#Preview {
    FrameworkSelectionView(viewModel: FrameworkSelectionViewModel(navigationBarDataSource: NavigationBarDataSource()))
}
