//
//  SwiftUIScreenView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/24.
//

import SwiftUI

struct SwiftUIScreenView<ViewModel: SwiftUIScreenViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        Text("SwiftUI")
    }
}

#Preview {
    SwiftUIScreenView(viewModel: SwiftUIScreenViewModel())
}