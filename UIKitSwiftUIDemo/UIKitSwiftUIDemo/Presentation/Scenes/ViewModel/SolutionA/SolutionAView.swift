//
//  SolutionAView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/09.
//

import SwiftUI

struct SolutionAView<ViewModel: SolutionAViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    @State var name = ""
    @State var isActionEnabled = false
    
    var body: some View {
        VStack(spacing: 10) {
            TextField("Name",
                      text: $name)
                .textFieldStyle(.roundedBorder)
            Button {
                
            } label: {
                Text("Register")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .disabled(!isActionEnabled)
        }
        .padding()
        .onReceive(viewModel.isActionEnabledPublisher) { isActionEnabled in
            self.isActionEnabled = isActionEnabled
        }
        .onReceive(viewModel.namePublisher) { name in
            guard self.name != name else { return }
            self.name = name
        }
        .onChange(of: name) { _, newValue in
            self.viewModel.setName(newValue)
        }
    }
}

#Preview {
    SolutionAView(viewModel: SolutionAViewModel())
}
