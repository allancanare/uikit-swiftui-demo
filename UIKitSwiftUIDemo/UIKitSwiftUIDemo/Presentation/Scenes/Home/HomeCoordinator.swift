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
    
}

// MARK: - Class Declaration
final class HomeCoordinator: BaseCoordinator {
    // MARK: Public Properties
    weak var delegate: HomeCoordinatorDelegate?
    
    // MARK: Private Properties
    private let presentationStyle: PresentationStyle
    private let navigationController = UINavigationController()
    
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
private extension HomeCoordinator {
    func showViewModelSelection() {
        let view = HomeSelectionView(delegate: self)
        let viewController = UIHostingController(rootView: view)
        viewController.title = "Home"
        navigationController.pushViewController(viewController,
                                                animated: true)
        
        switch presentationStyle {
        case .root(let window):
            window.rootViewController = navigationController
        default:
            fatalError("HomeCoordinator only supports root presentation style")
        }
    }
}

// MARK: - ViewModelSelectionViewModelDelegate
extension HomeCoordinator: HomeSelectionViewDelegate {
    func homeSelectionViewWillShowViewModel() {
        let coordinator = ViewModelCoordinator(presentationStyle: .push(navigationController))
        coordinate(to: coordinator)
    }
    
    func homeSelectionViewWillShowSwiftUIKitInterop() {
        let coordinator = SwiftUIKitInteropCoordinator(presentationStyle: .push(navigationController))
        coordinate(to: coordinator)
    }
    
    func homeSelectionViewWillShowExampleScreen() {
        let coordinator = ExampleScreenCoordinator(presentationStyle: .present(navigationController, 
                                                                               isFullScreen: true))
        coordinate(to: coordinator)
    }
}
