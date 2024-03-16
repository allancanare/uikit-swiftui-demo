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
    
}

// MARK: - Class Declaration
final class ExampleScreenCoordinator: BaseCoordinator {
    // MARK: Public Properties
    weak var delegate: ExampleScreenCoordinatorDelegate?
    
    // MARK: Private Properties
    private let presentationStyle: PresentationStyle
    private let ownNavigationController = UINavigationController()
    private var navigationController: UINavigationController {
        switch presentationStyle {
        case .present:
            return ownNavigationController
        default:
            fatalError("ExampleScreenCoordinator only supports present presentation style")
        }
    }
    
    // MARK: Initialization
    init(presentationStyle: PresentationStyle) {
        self.presentationStyle = presentationStyle
    }
    
    // MARK: Overrides
    override func start() {
        showLogin()
    }
}

// MARK: - Private Functions
private extension ExampleScreenCoordinator {
    func showLogin() {
        let viewModel = LoginViewModel()
        let view = LoginView(viewModel: viewModel)
        let viewController = BaseHostingController(rootView: view)
        viewController.navigationBarDataSource = viewModel
        
        navigationController.pushViewController(viewController,
                                                animated: true)
        switch presentationStyle {
        case .present(let viewController, let isFullScreen):
            if isFullScreen {
                navigationController.modalPresentationStyle = .fullScreen
            }
            viewController.present(navigationController,
                                   animated: true)
        default:
            fatalError("ExampleScreenCoordinator only supports present presentation style")
        }
    }
}
