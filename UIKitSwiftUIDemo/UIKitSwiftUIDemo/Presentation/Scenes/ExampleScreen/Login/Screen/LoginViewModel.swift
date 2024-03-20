//
//  LoginViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/14.
//

import UIKit

protocol LoginViewModelDelegate: AnyObject {
    func loginViewModelWillClose(_ viewModel: any LoginViewModelProtocol)
    func loginViewModelWillShowUserList(_ viewModel: any LoginViewModelProtocol)
}

protocol LoginViewModelProtocol: ObservableObject {
    var username: String { get set }
    var password: String { get set }
    
    func login()
}

final class LoginViewModel {
    // MARK: Public Properties
    weak var delegate: LoginViewModelDelegate?
    
    @Published var username = ""
    @Published var password = ""
    
    // MARK: Private Properties
    private let navigationBarDataSource: NavigationBarDataSource
    
    init(navigationBarDataSource: NavigationBarDataSource) {
        self.navigationBarDataSource = navigationBarDataSource
        generateNavigationBarData()
    }
}

// MARK: - LoginViewModelProtocol
extension LoginViewModel: LoginViewModelProtocol {
    func login() {
        delegate?.loginViewModelWillShowUserList(self)
    }
}

// MARK: - Private Functions
private extension LoginViewModel {
    func generateNavigationBarData() {
        let closeButtonData = NavigationBar.ButtonType.ButtonData(icon: UIImage(systemName: "xmark")!) { [weak self] in
            guard let self else { return }
            self.delegate?.loginViewModelWillClose(self)
        }
        let closeButton = NavigationBar.ButtonType.button(closeButtonData)
        navigationBarDataSource.setLeftBarButtons([closeButton])
    }
}

// MARK: - NavigationBarDataSourceDelegate
extension LoginViewModel: NavigationBarDataSourceDelegate {
    func navigationBarDataSourceWillDismiss(_ navigationBarDataSource: NavigationBarDataSource) {
        delegate?.loginViewModelWillClose(self)
    }
}
