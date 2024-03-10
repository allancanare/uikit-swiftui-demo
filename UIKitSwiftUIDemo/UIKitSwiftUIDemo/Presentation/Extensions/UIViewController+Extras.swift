//
//  UIViewController+Extras.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/10.
//

import UIKit

extension UIViewController {
    /// Adds a `UIViewController` to a given `UIView`
    func add(_ child: UIViewController,
             toSubview view: UIView) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: view.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    /// Removes a `UIViewController` from parent.
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
