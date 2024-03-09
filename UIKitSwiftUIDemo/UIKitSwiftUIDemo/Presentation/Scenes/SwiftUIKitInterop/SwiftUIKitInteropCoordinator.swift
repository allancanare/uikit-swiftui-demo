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
    
}

// MARK: - Class Declaration
final class SwiftUIKitInteropCoordinator: BaseCoordinator {
    // MARK: Public Properties
    weak var delegate: SwiftUIKitInteropCoordinatorDelegate?
    
    // MARK: Private Properties
    private let presentationStyle: PresentationStyle
    private let ownNavigationController = UINavigationController()
    private var navigationController: UINavigationController {
        switch presentationStyle {
        case .push(let navigationController):
            return navigationController
        default:
            return ownNavigationController
        }
    }
    
    // MARK: Initialization
    init(presentationStyle: PresentationStyle) {
        self.presentationStyle = presentationStyle
    }
    
    // MARK: Overrides
    override func start() {
        showFrameworkSelection()
    }
}

// MARK: - Private Functions
private extension SwiftUIKitInteropCoordinator {
    func showFrameworkSelection() {
        let view = FrameworkSelectionView(delegate: self)
        let viewController = UIHostingController(rootView: view)
        viewController.title = "Framework Selection"
        
        switch presentationStyle {
        case .root(let window):
            navigationController.pushViewController(viewController,
                                                    animated: true)
            window.rootViewController = navigationController
        case .push:
            navigationController.pushViewController(viewController,
                                                    animated: true)
        default:
            fatalError("SwiftUIKitInteropCoordinator only supports root and push presentation styles")
        }
    }
}

extension SwiftUIKitInteropCoordinator: FrameworkSelectionViewDelegate {
    func frameworkSelectionViewWillShowUIKit() {
        let viewModel = UIKitScreenViewModel()
        viewModel.delegate = self
        let viewController = R.storyboard.uiKitScreen.loginViewController()!
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
    
    func frameworkSelectionViewWillShowSwiftUI() {
        let view = SwiftUIScreenView(viewModel: SwiftUIScreenViewModel())
        let viewController = UIHostingController(rootView: view)
        viewController.title = "SwiftUI"
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
}

extension SwiftUIKitInteropCoordinator: UIKitScreenViewModelDelegate {
    func uiKitScreenViewModelWillShowSwiftUIScreen(_ viewModel: UIKitScreenViewModelProtocol) {
    }
}
