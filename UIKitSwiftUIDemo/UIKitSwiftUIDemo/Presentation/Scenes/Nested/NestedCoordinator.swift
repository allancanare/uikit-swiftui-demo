//
//  NestedCoordinator.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/17.
//

import UIKit
import SwiftUI

// MARK: - Protocols
protocol NestedCoordinatorDelegate: AnyObject {
    func nestedCoordinatorWillDismiss(_ coordinator: NestedCoordinator)
}

// MARK: - Class Declaration
final class NestedCoordinator: BaseCoordinator {
    // MARK: Public Properties
    weak var delegate: NestedCoordinatorDelegate?
    
    // MARK: Initialization
    override init(presentationStyle: PresentationStyle) {
        super.init(presentationStyle: presentationStyle)
    }
    
    // MARK: Overrides
    override func start() {
        showViewModelSelection()
    }
    
    override func didDismissPushedFirstScreen() {
        delegate?.nestedCoordinatorWillDismiss(self)
    }
}

// MARK: - Private Functions
private extension NestedCoordinator {
    func showViewModelSelection() {
        let navigationBarDataSource = NavigationBarDataSource(hasCloseButton: isCoordinatorPresented)
        let viewModel = NestedViewModel(navigationBarDataSource: navigationBarDataSource)
        viewModel.delegate = self
        navigationBarDataSource.delegate = viewModel
        let view = NestedView(viewModel: viewModel)
        let viewController = BaseHostingController(rootView: view)
        viewController.navigationBarDataSource = navigationBarDataSource
        showFirstScreen(viewController)
    }
}

// MARK: - NestedViewModelModelDelegate
extension NestedCoordinator: NestedViewModelDelegate {
    func nestedViewModelWillClose(_ viewModel: any NestedViewModelProtocol) {
        dismissCoordinatorScreens {
            self.delegate?.nestedCoordinatorWillDismiss(self)
        }
    }
    
    func nestedViewModelWillShowPushedScreen(_ viewModel: any NestedViewModelProtocol) {
        let coordinator = NestedCoordinator(presentationStyle: .push(navigationController))
        coordinator.delegate = self
        coordinate(to: coordinator)
    }
    
    func nestedViewModelWillShowPresentedScreen(_ viewModel: any NestedViewModelProtocol) {
        let coordinator = NestedCoordinator(presentationStyle: .present(navigationController))
        coordinator.delegate = self
        coordinate(to: coordinator)
    }
}

// MARK: - NestedCoordinatorDelegate
extension NestedCoordinator: NestedCoordinatorDelegate {
    func nestedCoordinatorWillDismiss(_ coordinator: NestedCoordinator) {
        print("NestedCoordinator - remove NestedCoordinator")
        remove(childCoordinator: coordinator)
    }
}
