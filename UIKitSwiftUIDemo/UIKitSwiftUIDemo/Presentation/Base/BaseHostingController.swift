//
//  BaseHostingController.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/11.
//

import SwiftUI
import Combine

class BaseHostingController<Content: View>: UIHostingController<Content> {
    weak var navigationBarDataSource: NavigationBar.DataSource? {
        didSet {
            cancellables = Set<AnyCancellable>()
            guard let navigationBarDataSource else { return }
            setupBindings(navigationBarDataSource)
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
}

private extension BaseHostingController {
    func setupBindings(_ navigationBarDataSource: NavigationBar.DataSource) {
        navigationBarDataSource
            .navigtionTitle
            .sink { title in
                self.title = title
            }
            .store(in: &cancellables)
        
        navigationBarDataSource
            .navigationButtons
            .sink { [weak self] buttons in
                self?.setNavigationBarButtons(buttons)
            }
            .store(in: &cancellables)
    }
    
    func setNavigationBarButtons(_ buttonTypes: [NavigationBar.ButtonType]) {
        navigationItem.rightBarButtonItems = nil
        var buttons = [UIBarButtonItem]()
        buttonTypes.forEach { buttonType in
            switch buttonType {
            case .button(let buttonData):
                let action = UIAction(image: buttonData.icon) { _ in
                    buttonData.action()
                }
                let button = UIBarButtonItem(primaryAction: action)
                buttons.append(button)
            case .menu(let menuData):
                var menuItems = [UIMenuElement]()
                menuData.items.forEach { item in
                    let menuElement = UIAction(title: item.title, image: item.icon) { _ in
                        item.action()
                    }
                    menuItems.append(menuElement)
                }
                let menu = UIMenu(children: menuItems)
                let button = UIBarButtonItem(image: menuData.icon,
                                             menu: menu)
                buttons.append(button)
            }
        }
        navigationItem.rightBarButtonItems = buttons
    }
}
