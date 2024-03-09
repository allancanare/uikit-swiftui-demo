//
//  SolutionBView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/09.
//

import SwiftUI

struct SolutionBView<ViewModel: SolutionBViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            TextField("Name",
                      text: $viewModel.name)
                .textFieldStyle(.roundedBorder)
            Button {
                
            } label: {
                Text("Register")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!viewModel.isActionEnabled)
        }
        .padding()
    }
}

#Preview {
    SolutionBView(viewModel: SolutionBViewModel())
}
