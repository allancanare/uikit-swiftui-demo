//
//  LoginView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/14.
//

import SwiftUI

struct LoginView<ViewModel: LoginViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        Text("Login View")
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
