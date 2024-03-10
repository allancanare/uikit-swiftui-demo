//
//  SwiftUIWithViewModelView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/10.
//

import SwiftUI

struct SwiftUIWithViewModelView<ViewModel: SwiftUIWithViewModelViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 8) {
            Text(viewModel.title)
                .lineLimit(nil)
                .font(.title)
            Button {
                viewModel.didTapButton()
            } label: {
                Text("Tap Me")
                    .font(.headline)
            }
            Text("Button Tap Counter: \(viewModel.tapCount)")
                .font(.caption)
        }
    }
}

#Preview {
    SwiftUIWithViewModelView(viewModel: SwiftUIWithViewModelViewModel())
}
