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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .systemRed
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

private extension BaseHostingController {
    func setupBindings(_ navigationBarDataSource: NavigationBar.DataSource) {
        navigationBarDataSource
            .navigationBarTitle
            .sink { title in
                self.title = title
            }
            .store(in: &cancellables)
        
        navigationBarDataSource
            .leftNavigationBarButtons
            .sink { [weak self] buttons in
                self?.setLeftNavigationBarButtons(buttons)
            }
            .store(in: &cancellables)
        
        navigationBarDataSource
            .rightNavigationBarButtons
            .sink { [weak self] buttons in
                self?.setRightNavigationBarButtons(buttons)
            }
            .store(in: &cancellables)
        
        navigationBarDataSource
            .isNavigationBarVisible
            .sink { [weak self] isVisible in
                self?.navigationController?.setNavigationBarHidden(!isVisible,
                                                                   animated: true)
            }
            .store(in: &cancellables)
    }
    
    func setLeftNavigationBarButtons(_ buttonTypes: [NavigationBar.ButtonType]) {
        navigationItem.leftBarButtonItems = nil
        let buttons = getBarButtonItem(for: buttonTypes)
        navigationItem.leftBarButtonItems = buttons
    }
    
    func setRightNavigationBarButtons(_ buttonTypes: [NavigationBar.ButtonType]) {
        navigationItem.rightBarButtonItems = nil
        let buttons = getBarButtonItem(for: buttonTypes)
        navigationItem.rightBarButtonItems = buttons
    }
    
    func getBarButtonItem(for buttonTypes: [NavigationBar.ButtonType]) -> [UIBarButtonItem] {
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
        return buttons
    }
}
