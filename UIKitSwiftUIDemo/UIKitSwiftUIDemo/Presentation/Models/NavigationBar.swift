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
        var navigtionTitle: Published<String>.Publisher { get }
        var navigationButtons: Published<[NavigationBar.ButtonType]>.Publisher { get }
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
