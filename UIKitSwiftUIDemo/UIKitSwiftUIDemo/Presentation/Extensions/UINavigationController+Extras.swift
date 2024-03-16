//
//  UINavigationController+Extras.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/16.
//

import UIKit

extension UINavigationController {
    func popViewController(animated: Bool = true,
                           completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func popToViewController(_ viewController: UIViewController,
                             animated: Bool = true,
                             completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popToViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    func pushViewController(viewController: UIViewController,
                            animated: Bool = true,
                            completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController,
                           animated: animated)
        CATransaction.commit()
    }
}
