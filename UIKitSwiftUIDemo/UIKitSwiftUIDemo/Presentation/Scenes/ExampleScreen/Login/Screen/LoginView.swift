//
//  LoginView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/14.
//

import SwiftUI
import AtomicDS

struct LoginView<ViewModel: LoginViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: .init(spacing: .extraExtraLarge)) {
            inputFields
            loginButton
        }
        .padding(.horizontal, .init(spacing: .extraExtraLarge))
    }
    
    var inputFields: some View {
        VStack(spacing: .init(spacing: .small)) {
            AtomicDS.TextField(input: $viewModel.username,
                               placeholder: "Username",
                               style: .normal)
            AtomicDS.TextField(input: $viewModel.password,
                               placeholder: "Password",
                               style: .normal)
        }
    }
    
    var loginButton: some View {
        AtomicDS.Button(leftIcon: .apple,
                        title: "Login",
                        style: .primary) {
            viewModel.login()
        }
        .disabled(!viewModel.canLogin)
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(navigationBarDataSource: NavigationBarDataSource()))
}
