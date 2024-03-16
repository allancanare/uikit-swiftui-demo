//
//  SwiftUIScreenViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/24.
//

import Foundation
import Combine
import UIKit

protocol SwiftUIScreenViewModelDelegate: AnyObject {
    
}

protocol SwiftUIScreenViewModelProtocol: ObservableObject {
    var title: String { get }
}

final class SwiftUIScreenViewModel {
    // MARK: Public Properties
    weak var delegate: SwiftUIScreenViewModelDelegate?
    
    // MARK: Private Properties
    @Published private var titlePublished = "UIKit UILabel"
    
    private let navigationBarDataSource: NavigationBarDataSource
    
    init(navigationBarDataSource: NavigationBarDataSource) {
        self.navigationBarDataSource = navigationBarDataSource
        generateNavigationBarData()
        updateProperties()
    }
}

// MARK: - SwiftUIScreenViewModelProtocol
extension SwiftUIScreenViewModel: SwiftUIScreenViewModelProtocol {
    var title: String {
        return titlePublished
    }
}

// MARK: - Private Functions
private extension SwiftUIScreenViewModel {
    func updateProperties() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.titlePublished = "UIKit UILabel - Without ViewModel"
        }
    }
        
    func generateNavigationBarData() {
        // navigation title
        navigationBarDataSource.setTitle("SwiftUI")
        
        // button
        let favoriteButtonData = NavigationBar.ButtonType.ButtonData(icon: UIImage(systemName: "star")!) {
            print("SwiftUIScreenViewModel - did tap favorite navigation button")
        }
        let favoriteButton = NavigationBar.ButtonType.button(favoriteButtonData)
        
        // menu
        let addToPhotos: NavigationBar.ButtonType.MenuData.ItemData
        addToPhotos = .init(title: "Add to Photos",
                            icon: UIImage(systemName: "photo")!,
                            action: {
            print("SwiftUIScreenViewModel - did tap add to Photos menu item")
        })
        let copy: NavigationBar.ButtonType.MenuData.ItemData
        copy = .init(title: "Copy",
                     icon: UIImage(systemName: "doc.on.doc")!, action: {
            print("SwiftUIScreenViewModel - did tap copy menu item")
        })
        let menuData = NavigationBar.ButtonType.MenuData.init(icon: UIImage(systemName: "square.and.arrow.up")!,
                                                              items: [addToPhotos, copy])
        let menuButton = NavigationBar.ButtonType.menu(menuData)
        
        // navigation button
        navigationBarDataSource.setRightBarButtons([favoriteButton, menuButton])
    }
}
