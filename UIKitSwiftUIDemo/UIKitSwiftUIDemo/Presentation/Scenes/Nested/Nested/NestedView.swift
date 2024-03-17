//
//  NestedView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/17.
//

import SwiftUI

struct NestedView<ViewModel: NestedViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List {
            Button {
                viewModel.showPushedScreen()
            } label: {
                Text("Push Screen")
            }
            Button {
                viewModel.showPresentedScreen()
            } label: {
                Text("Present Screen")
            }
        }
    }
}

#Preview {
    NestedView(viewModel: NestedViewModel(navigationBarDataSource: NavigationBarDataSource()))
}
