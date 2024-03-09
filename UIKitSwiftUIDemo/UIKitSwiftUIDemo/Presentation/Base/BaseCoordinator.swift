//
//  BaseCoordinator.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/23.
//

import UIKit

// MARK: - Class Declaration
class BaseCoordinator {
    // MARK: Properties
    private let identifier: UUID = UUID()
    private var childCoordinators: [UUID: Any] = [:]
    
    // MARK: Overridable Methods
    func start() {
        fatalError("Must be overriden by subclass")
    }
}

// MARK: - Public Functions
extension BaseCoordinator {
    func coordinate(to coordinator: BaseCoordinator) {
        add(childCoordinator: coordinator)
        coordinator.start()
    }
    
    func remove(childCoordinator: BaseCoordinator) {
        childCoordinators[childCoordinator.identifier] = nil
    }
}

// MARK: - Private Functions
private extension BaseCoordinator {
    private func add(childCoordinator: BaseCoordinator) {
        childCoordinators[childCoordinator.identifier] = childCoordinator
    }
}
