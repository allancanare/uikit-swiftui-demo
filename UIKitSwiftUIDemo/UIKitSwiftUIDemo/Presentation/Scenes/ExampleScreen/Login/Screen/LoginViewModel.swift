//
//  LoginViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/14.
//

import UIKit
import Combine

protocol LoginViewModelDelegate: AnyObject {
    func loginViewModelWillClose(_ viewModel: any LoginViewModelProtocol)
    func loginViewModelWillShowUserList(_ viewModel: any LoginViewModelProtocol)
}

protocol LoginViewModelProtocol: ObservableObject {
    var username: String { get set }
    var password: String { get set }
    var canLogin: Bool { get }
    
    func login()
}

final class LoginViewModel {
    // MARK: Public Properties
    weak var delegate: LoginViewModelDelegate?
    
    @Published var username = ""
    @Published var password = ""
    @Published var canLogin = false
    
    // MARK: Private Properties
    private let navigationBarDataSource: NavigationBarDataSource
    private var cancellables = Set<AnyCancellable>()
    
    init(navigationBarDataSource: NavigationBarDataSource) {
        self.navigationBarDataSource = navigationBarDataSource
        generateNavigationBarData()
        setupBindings()
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
        navigationBarDataSource.setTitle("Login")
    }
    
    func setupBindings() {
        $username
            .combineLatest($password)
            .map {
                return !$0.0.isEmpty && !$0.1.isEmpty
            }
            .sink(receiveValue: { [weak self] hasInput in
                self?.canLogin = hasInput
            })
            .store(in: &cancellables)
    }
}

// MARK: - NavigationBarDataSourceDelegate
extension LoginViewModel: NavigationBarDataSourceDelegate {
    func navigationBarDataSourceWillDismiss(_ navigationBarDataSource: NavigationBarDataSource) {
        delegate?.loginViewModelWillClose(self)
    }
}
