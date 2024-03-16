//
//  SwiftUIKitInteropCoordinator.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/23.
//

import UIKit
import SwiftUI

// MARK: - Protocols
protocol SwiftUIKitInteropCoordinatorDelegate: AnyObject {
    func swiftUIKitInteropCoordinatorWillDismiss(_ coordinator: SwiftUIKitInteropCoordinator)
}

// MARK: - Class Declaration
final class SwiftUIKitInteropCoordinator: BaseCoordinator {
    // MARK: Public Properties
    weak var delegate: SwiftUIKitInteropCoordinatorDelegate?
    
    // MARK: Initialization
    override init(presentationStyle: PresentationStyle) {
        super.init(presentationStyle: presentationStyle)
    }
    
    // MARK: Overrides
    override func start() {
        showFrameworkSelection()
    }
    
    override func didDismissPushedFirstScreen() {
        delegate?.swiftUIKitInteropCoordinatorWillDismiss(self)
    }
}

// MARK: - Private Functions
private extension SwiftUIKitInteropCoordinator {
    func showFrameworkSelection() {
        let navigationBarDataSource = NavigationBarDataSource(hasCloseButton: isCoordinatorPresented)
        let viewModel = FrameworkSelectionViewModel(navigationBarDataSource: navigationBarDataSource)
        viewModel.delegate = self
        navigationBarDataSource.delegate = viewModel
        let view = FrameworkSelectionView(viewModel: viewModel)
        let viewController = BaseHostingController(rootView: view)
        viewController.navigationBarDataSource = navigationBarDataSource
        showFirstScreen(viewController)
    }
}

// MARK: - FrameworkSelectionViewModelDelegate
extension SwiftUIKitInteropCoordinator: FrameworkSelectionViewModelDelegate {
    func frameworkSelectionViewModelWillClose(_ viewModel: any FrameworkSelectionViewModelProtocol) {
        dismissCoordinatorScreens {
            self.delegate?.swiftUIKitInteropCoordinatorWillDismiss(self)
        }
    }
    
    func frameworkSelectionViewModelWillShowUIKit(_ viewModel: any FrameworkSelectionViewModelProtocol) {
        let viewModel = UIKitScreenViewModel()
        viewModel.delegate = self
        let viewController = R.storyboard.uiKitScreen.loginViewController()!
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
    
    func frameworkSelectionViewModelWillShowSwiftUI(_ viewModel: any FrameworkSelectionViewModelProtocol) {
        let navigationBarDataSource = NavigationBarDataSource()
        let viewModel = SwiftUIScreenViewModel(navigationBarDataSource: navigationBarDataSource)
        viewModel.delegate = self
        let view = SwiftUIScreenView(viewModel: viewModel)
        let viewController = BaseHostingController(rootView: view)
        viewController.navigationBarDataSource = navigationBarDataSource
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
}

// MARK: - UIKitScreenViewModelDelegate
extension SwiftUIKitInteropCoordinator: UIKitScreenViewModelDelegate {
    
}

// MARK: - SwiftUIScreenViewModelDelegate
extension SwiftUIKitInteropCoordinator: SwiftUIScreenViewModelDelegate {
    
}
