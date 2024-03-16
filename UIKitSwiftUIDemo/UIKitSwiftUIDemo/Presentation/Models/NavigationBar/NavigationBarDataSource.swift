//
//  NavigationBarDataSource.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/16.
//

import UIKit

protocol NavigationBarDataSourceDelegate: AnyObject {
    func navigationBarDataSourceWillDismiss(_ navigationBarDataSource: NavigationBarDataSource)
}

final class NavigationBarDataSource {
    weak var delegate: NavigationBarDataSourceDelegate?
    
    @Published private var navigationBarTitlePublished = ""
    @Published private var leftNavigationBarButtonsPublished = [NavigationBar.ButtonType]()
    @Published private var rightNavigationBarButtonsPublished = [NavigationBar.ButtonType]()
    @Published private var isNavigationBarVisiblePublished = true
    
    init(hasCloseButton: Bool = false) {
        if hasCloseButton {
            createCloseButton()
        }
    }
}

extension NavigationBarDataSource {
    func setTitle(_ title: String) {
        navigationBarTitlePublished = title
    }
    
    func setLeftBarButtons(_ leftBarButtons: [NavigationBar.ButtonType]) {
        leftNavigationBarButtonsPublished = leftBarButtons
    }
    
    func setRightBarButtons(_ rightBarButtons: [NavigationBar.ButtonType]) {
        rightNavigationBarButtonsPublished = rightBarButtons
    }
    
    func setVisible(_ isVisible: Bool) {
        isNavigationBarVisiblePublished = isVisible
    }
}

extension NavigationBarDataSource: NavigationBar.DataSource {
    var navigationBarTitle: Published<String>.Publisher {
        return $navigationBarTitlePublished
    }
    
    var leftNavigationBarButtons: Published<[NavigationBar.ButtonType]>.Publisher {
        return $leftNavigationBarButtonsPublished
    }
    
    var rightNavigationBarButtons: Published<[NavigationBar.ButtonType]>.Publisher {
        return $rightNavigationBarButtonsPublished
    }
    
    var isNavigationBarVisible: Published<Bool>.Publisher {
        return $isNavigationBarVisiblePublished
    }
}

private extension NavigationBarDataSource {
    func createCloseButton() {
        let closeButtonData = NavigationBar.ButtonType.ButtonData(icon: UIImage(systemName: "xmark")!) { [weak self] in
            guard let self else { return }
            self.delegate?.navigationBarDataSourceWillDismiss(self)
        }
        let closeButton = NavigationBar.ButtonType.button(closeButtonData)
        setLeftBarButtons([closeButton])
    }
}
