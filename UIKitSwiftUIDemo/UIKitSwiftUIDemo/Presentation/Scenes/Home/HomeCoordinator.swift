//
//  HomeCoordinator.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/09.
//

import UIKit
import SwiftUI

// MARK: - Protocols
protocol HomeCoordinatorDelegate: AnyObject {
    func homeCoordinatorWillDismiss(_ coordinator: HomeCoordinator)
}

// MARK: - Class Declaration
final class HomeCoordinator: BaseCoordinator {
    // MARK: Public Properties
    weak var delegate: HomeCoordinatorDelegate?
    
    // MARK: Initialization
    override init(presentationStyle: PresentationStyle) {
        super.init(presentationStyle: presentationStyle)
    }
    
    // MARK: Overrides
    override func start() {
        showViewModelSelection()
    }
    
    override func didDismissPushedFirstScreen() {
        delegate?.homeCoordinatorWillDismiss(self)
    }
}

// MARK: - Private Functions
private extension HomeCoordinator {
    func showViewModelSelection() {
        let navigationBarDataSource = NavigationBarDataSource(hasCloseButton: isCoordinatorPresented)
        let viewModel = HomeSelectionViewModel(navigationBarDataSource: navigationBarDataSource)
        viewModel.delegate = self
        navigationBarDataSource.delegate = viewModel
        let view = HomeSelectionView(viewModel: viewModel)
        let viewController = BaseHostingController(rootView: view)
        viewController.navigationBarDataSource = navigationBarDataSource
        showFirstScreen(viewController)
    }
}

// MARK: - HomeSelectionViewModelDelegate
extension HomeCoordinator: HomeSelectionViewModelDelegate {
    func homeSelectionViewModelWillClose(_ viewModel: any HomeSelectionViewModelProtocol) {
        dismissCoordinatorScreens {
            self.delegate?.homeCoordinatorWillDismiss(self)
        }
    }
    
    func homeSelectionViewModelWillShowViewModel(_ viewModel: any HomeSelectionViewModelProtocol) {
        let coordinator = ViewModelCoordinator(presentationStyle: .push(navigationController))
        coordinator.delegate = self
        coordinate(to: coordinator)
    }
    
    func homeSelectionViewModelWillShowSwiftUIKitInterop(_ viewModel: any HomeSelectionViewModelProtocol) {
        let coordinator = SwiftUIKitInteropCoordinator(presentationStyle: .push(navigationController))
        coordinator.delegate = self
        coordinate(to: coordinator)
    }
    
    func homeSelectionViewModelWillShowExampleScreen(_ viewModel: any HomeSelectionViewModelProtocol) {
        let coordinator = ExampleScreenCoordinator(presentationStyle: .present(navigationController))
        coordinator.delegate = self
        coordinate(to: coordinator)
    }
}

// MARK: - ViewModelCoordinatorDelegate
extension HomeCoordinator: ViewModelCoordinatorDelegate {
    func viewModelCoordinatorWillDismiss(_ coordinator: ViewModelCoordinator) {
        print("HomeCoordinator - remove ViewModelCoordinator")
        remove(childCoordinator: coordinator)
    }
}

// MARK: - SwiftUIKitInteropCoordinatorDelegate
extension HomeCoordinator: SwiftUIKitInteropCoordinatorDelegate {
    func swiftUIKitInteropCoordinatorWillDismiss(_ coordinator: SwiftUIKitInteropCoordinator) {
        print("HomeCoordinator - remove SwiftUIKitInteropCoordinator")
        remove(childCoordinator: coordinator)
    }
}

// MARK: - ExampleScreenCoordinatorDelegate
extension HomeCoordinator: ExampleScreenCoordinatorDelegate {
    func exampleScreenCoordinatorWillDismiss(_ coordinator: ExampleScreenCoordinator) {
        print("HomeCoordinator - remove ExampleScreenCoordinator")
        remove(childCoordinator: coordinator)
    }
}
