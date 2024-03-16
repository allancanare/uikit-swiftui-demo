//
//  ExampleScreenCoordinator.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/11.
//

import UIKit
import SwiftUI

// MARK: - Protocols
protocol ExampleScreenCoordinatorDelegate: AnyObject {
    func exampleScreenCoordinatorWillDismiss(_ coordinator: ExampleScreenCoordinator)
}

// MARK: - Class Declaration
final class ExampleScreenCoordinator: BaseCoordinator {
    // MARK: Public Properties
    weak var delegate: ExampleScreenCoordinatorDelegate?
    
    // MARK: Initialization
    override init(presentationStyle: PresentationStyle) {
        super.init(presentationStyle: presentationStyle)
    }
    
    // MARK: Overrides
    override func start() {
        showLogin()
    }
    
    override func didDismissPushedFirstScreen() {
        delegate?.exampleScreenCoordinatorWillDismiss(self)
    }
}

// MARK: - Private Functions
private extension ExampleScreenCoordinator {
    func showLogin() {
        let navigationBarDataSource = NavigationBarDataSource(hasCloseButton: isCoordinatorPresented)
        let viewModel = LoginViewModel(navigationBarDataSource: navigationBarDataSource)
        viewModel.delegate = self
        navigationBarDataSource.delegate = viewModel
        let view = LoginView(viewModel: viewModel)
        let viewController = BaseHostingController(rootView: view)
        viewController.navigationBarDataSource = navigationBarDataSource
        showFirstScreen(viewController)
    }
}

// MARK: - LoginViewModelDelegate
extension ExampleScreenCoordinator: LoginViewModelDelegate {
    func loginViewModelWillClose(_ viewModel: any LoginViewModelProtocol) {
        dismissCoordinatorScreens {
            self.delegate?.exampleScreenCoordinatorWillDismiss(self)
        }
    }
}
