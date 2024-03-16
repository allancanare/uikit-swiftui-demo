//
//  SwiftUIScreenView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/24.
//

import SwiftUI

struct SwiftUIScreenView<ViewModel: SwiftUIScreenViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        UIKitWithoutViewModelViewComponent(title: viewModel.title) {
            print("SwiftUIScreenView - View without ViewModel - Button Tapped")
        }
        .padding()
    }
}

#Preview {
    SwiftUIScreenView(viewModel: SwiftUIScreenViewModel(navigationBarDataSource: NavigationBarDataSource()))
}
