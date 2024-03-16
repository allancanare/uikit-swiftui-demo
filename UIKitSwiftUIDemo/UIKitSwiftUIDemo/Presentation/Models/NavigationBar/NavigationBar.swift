//
//  NavigationBar.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/11.
//

import UIKit
import Combine

enum NavigationBar { }

extension NavigationBar {
    protocol DataSource: AnyObject {
        var navigationBarTitle: Published<String>.Publisher { get }
        var leftNavigationBarButtons: Published<[NavigationBar.ButtonType]>.Publisher { get }
        var rightNavigationBarButtons: Published<[NavigationBar.ButtonType]>.Publisher { get }
        var isNavigationBarVisible: Published<Bool>.Publisher { get }
    }
    
    enum ButtonType {
        case button(ButtonData)
        case menu(MenuData)
    }
}

extension NavigationBar.ButtonType {
    struct ButtonData {
        let icon: UIImage
        let action: () -> Void
    }
    
    struct MenuData {
        let icon: UIImage
        let items: [ItemData]
    }
}

extension NavigationBar.ButtonType.MenuData {
    struct ItemData {
        let title: String
        let icon: UIImage
        let action: () -> Void
    }
}
