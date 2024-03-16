//
//  LoginViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/14.
//

import Foundation

protocol LoginViewModelProtocol: ObservableObject {
    
}

final class LoginViewModel {
    @Published private var navigationTitlePublished = "Login"
    @Published private var navigationButtonsPublished = [NavigationBar.ButtonType]()
}

extension LoginViewModel: LoginViewModelProtocol { }

extension LoginViewModel: NavigationBar.DataSource {
    var navigtionTitle: Published<String>.Publisher {
        return $navigationTitlePublished
    }
    
    var navigationButtons: Published<[NavigationBar.ButtonType]>.Publisher {
        return $navigationButtonsPublished
    }
}
