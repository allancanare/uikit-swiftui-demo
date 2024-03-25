//
//  LoginView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/14.
//

import SwiftUI

struct LoginView<ViewModel: LoginViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    @State private var animationsRunning = true
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 8) {
                TextField("Username",
                          text: $viewModel.username)
                .textFieldStyle(.roundedBorder)
                TextField("Password",
                          text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
            }
            Button("Login") {
                viewModel.login()
            }
            .disabled(!viewModel.canLogin)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(navigationBarDataSource: NavigationBarDataSource()))
}
