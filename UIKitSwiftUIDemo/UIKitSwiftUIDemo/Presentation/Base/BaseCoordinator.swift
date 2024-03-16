//
//  BaseCoordinator.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/23.
//

import UIKit

// MARK: - Class Declaration
class BaseCoordinator: NSObject {
    // MARK: Public Properties
    let presentationStyle: PresentationStyle
    var navigationController: UINavigationController {
        switch presentationStyle {
        case .present, .root:
            guard let myNavigationController else {
                fatalError("Failed to set myNavigationController")
            }
            return myNavigationController
        case .push(let navigationController):
            return navigationController
        }
    }
    var isCoordinatorPresented: Bool {
        switch presentationStyle {
        case .present:
            return true
        default:
            return false
        }
    }
    
    // MARK: Private Properties
    private let identifier: UUID = UUID()
    private var childCoordinators: [UUID: Any] = [:]
    
    private var previousViewController: UIViewController?
    private var myNavigationController: UINavigationController?
    
    init(presentationStyle: PresentationStyle) {
        self.presentationStyle = presentationStyle
        
        switch presentationStyle {
        case .present(let viewController):
            previousViewController = viewController
            myNavigationController = UINavigationController()
        case .push(let navigationController):
            previousViewController = navigationController.topViewController
        case .root:
            myNavigationController = UINavigationController()
        }
        super.init()
        navigationController.delegate = self
    }
    
    // MARK: Overridable Methods
    func start() {
        fatalError("`start` must be overriden by subclass")
    }
    
    func didDismissPushedFirstScreen() {
        fatalError("`didDismissPushedFirstScreen` must be overriden by subclass")
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
        switch (presentationStyle, childCoordinator.presentationStyle) {
        case (.push, .push):
            navigationController.delegate = self
        default:
            break
        }
    }
    
    func showFirstScreen(_ firstViewController: UIViewController) {
        switch presentationStyle {
        case .present(let viewController):
            navigationController.pushViewController(firstViewController,
                                                    animated: false)
            navigationController.modalPresentationStyle = .fullScreen
            viewController.present(navigationController,
                                   animated: true)
        case .push(let navigationController):
            navigationController.pushViewController(firstViewController,
                                                    animated: true)
        case .root(let window):
            navigationController.pushViewController(firstViewController,
                                                    animated: false)
            window.rootViewController = navigationController
        }
    }
    
    func dismissCoordinatorScreens(completion: (() -> Void)?) {
        switch presentationStyle {
        case .present(let viewController):
            viewController.dismiss(animated: true, 
                                   completion: completion)
        case .push(let navigationController):
            guard let previousViewController else {
                navigationController.setViewControllers([], 
                                                        animated: false)
                completion?()
                return
            }
            navigationController.popToViewController(previousViewController, 
                                                     completion: completion)
        case .root(let window):
            window.rootViewController = nil
            completion?()
        }
    }
    
}

// MARK: - Private Functions
private extension BaseCoordinator {
    func add(childCoordinator: BaseCoordinator) {
        childCoordinators[childCoordinator.identifier] = childCoordinator
    }
}

// MARK: - UINavigationControllerDelegate
extension BaseCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, 
                              didShow viewController: UIViewController,
                              animated: Bool) {
        switch presentationStyle {
        case .push:
            if viewController == previousViewController {
                didDismissPushedFirstScreen()
            }
        default:
            break
        }
    }
}
