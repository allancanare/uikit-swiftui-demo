//
//  PresentationStyle.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/24.
//

import UIKit

enum PresentationStyle {
    case present(UIViewController, isFullScreen: Bool)
    case push(UINavigationController)
    case root(UIWindow)
}
