//
//  ViewModelCoordinator.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/09.
//

import UIKit
import SwiftUI

// MARK: - Protocols
protocol ViewModelCoordinatorDelegate: AnyObject {
    func viewModelCoordinatorWillDismiss(_ coordinator: ViewModelCoordinator)
}

// MARK: - Class Declaration
final class ViewModelCoordinator: BaseCoordinator {
    // MARK: Public Properties
    weak var delegate: ViewModelCoordinatorDelegate?
    
    // MARK: Initialization
    override init(presentationStyle: PresentationStyle) {
        super.init(presentationStyle: presentationStyle)
    }
    
    // MARK: Overrides
    override func start() {
        showViewModelSelection()
    }
    
    override func didDismissPushedFirstScreen() {
        delegate?.viewModelCoordinatorWillDismiss(self)
    }
}

// MARK: - Private Functions
private extension ViewModelCoordinator {
    func showViewModelSelection() {
        let navigationBarDataSource = NavigationBarDataSource()
        let viewModel = ViewModelSelectionViewModel(navigationBarDataSource: navigationBarDataSource)
        viewModel.delegate = self
        navigationBarDataSource.delegate = viewModel
        let view = ViewModelSelectionView(viewModel: viewModel)
        let viewController = BaseHostingController(rootView: view)
        viewController.navigationBarDataSource = navigationBarDataSource
        showFirstScreen(viewController)
    }
}

// MARK: - ViewModelSelectionViewModelDelegate
extension ViewModelCoordinator: ViewModelSelectionViewModelDelegate {
    func viewModelSelectionViewModelWillClose(_ viewModel: any ViewModelSelectionViewModelProtocol) {
        dismissCoordinatorScreens {
            self.delegate?.viewModelCoordinatorWillDismiss(self)
        }
    }
    
    func viewModelSelectionViewModelWillShowSolutionA(_ viewModel: any ViewModelSelectionViewModelProtocol) {
        let view = SolutionAView(viewModel: SolutionAViewModel())
        let viewController = BaseHostingController(rootView: view)
        viewController.title = "Solution A"
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
    
    func viewModelSelectionViewModelWillShowSolutionB(_ viewModel: any ViewModelSelectionViewModelProtocol) {
        let view = SolutionBView(viewModel: SolutionBViewModel())
        let viewController = BaseHostingController(rootView: view)
        viewController.title = "Solution B"
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
    
    func viewModelSelectionViewModelWillShowSolutionC(_ viewModel: any ViewModelSelectionViewModelProtocol) {
        let view = SolutionCView(viewModel: SolutionCViewModel())
        let viewController = BaseHostingController(rootView: view)
        viewController.title = "Solution C"
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
    
    func viewModelSelectionViewModelWillShowSwiftUIKitInterop(_ viewModel: any ViewModelSelectionViewModelProtocol) {
        let coordinator = SwiftUIKitInteropCoordinator(presentationStyle: .present(navigationController))
        coordinator.delegate = self
        coordinate(to: coordinator)
    }
}

// MARK: - SwiftUIKitInteropCoordinatorDelegate
extension ViewModelCoordinator: SwiftUIKitInteropCoordinatorDelegate {
    func swiftUIKitInteropCoordinatorWillDismiss(_ coordinator: SwiftUIKitInteropCoordinator) {
        print("ViewModelCoordinator - remove SwiftUIKitInteropCoordinator")
        remove(childCoordinator: coordinator)
    }
}
