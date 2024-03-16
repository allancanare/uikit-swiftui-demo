//
//  AppCoordinator.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/23.
//

import UIKit

// MARK: - Class Declaration
class AppCoordinator: BaseCoordinator {
    // MARK: Private Properties
    private let window: UIWindow
    
    // MARK: Init
    init(window: UIWindow) {
        self.window = window
        super.init(presentationStyle: .root(window))
    }
    
    // MARK: Overrides
    override func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        let coordinator = HomeCoordinator(presentationStyle: .push(navigationController))
        coordinator.delegate = self
        coordinate(to: coordinator)
    }
}

// MARK: - HomeCoordinatorDelegate
extension AppCoordinator: HomeCoordinatorDelegate {
    func homeCoordinatorWillDismiss(_ coordinator: HomeCoordinator) {
        print("AppCoordinator - remove HomeCoordinator")
        remove(childCoordinator: coordinator)
    }
}
