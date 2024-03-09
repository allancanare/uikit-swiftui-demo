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
    
}

// MARK: - Class Declaration
final class ViewModelCoordinator: BaseCoordinator {
    // MARK: Public Properties
    weak var delegate: ViewModelCoordinatorDelegate?
    
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
        showViewModelSelection()
    }
}

// MARK: - Private Functions
private extension ViewModelCoordinator {
    func showViewModelSelection() {
        let view = ViewModelSelectionView(delegate: self)
        let viewController = UIHostingController(rootView: view)
        viewController.title = "Solution Selection"
        
        switch presentationStyle {
        case .root(let window):
            navigationController.pushViewController(viewController,
                                                    animated: true)
            window.rootViewController = navigationController
        case .push:
            navigationController.pushViewController(viewController, 
                                                    animated: true)
        default:
            fatalError("ViewModelCoordinator only supports root and push presentation styles")
        }
    }
}

// MARK: - ViewModelSelectionViewModelDelegate
extension ViewModelCoordinator: ViewModelSelectionViewDelegate {
    func viewModelSelectionViewWillShowSolutionA() {
        let view = SolutionAView(viewModel: SolutionAViewModel())
        let viewController = UIHostingController(rootView: view)
        viewController.title = "Solution A"
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
    
    func viewModelSelectionViewWillShowSolutionB() {
        let view = SolutionBView(viewModel: SolutionBViewModel())
        let viewController = UIHostingController(rootView: view)
        viewController.title = "Solution B"
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
    
    func viewModelSelectionViewWillShowSolutionC() {
        let view = SolutionCView(viewModel: SolutionCViewModel())
        let viewController = UIHostingController(rootView: view)
        viewController.title = "Solution C"
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
}
