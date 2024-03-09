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
    }
    
    // MARK: Overrides
    override func start() {
        let coordinator = HomeCoordinator(presentationStyle: .root(window))
        coordinate(to: coordinator)
    }
}
