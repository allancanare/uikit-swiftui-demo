//
//  SwiftUIScreenViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/24.
//

import Foundation
import Combine
import UIKit

protocol SwiftUIScreenViewModelProtocol: ObservableObject {
    var title: String { get set }
}

final class SwiftUIScreenViewModel {
    @Published var title = "UIKit UILabel"
    @Published var navigationTitlePublished = "Title"
    @Published var navigationButtonsPublished = [NavigationBar.ButtonType]()
    
    init() {
        updateProperties()
    }
    
    func updateProperties() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.title = "UIKit UILabel - Without ViewModel"
        }
        
        func generateNavigationBarData() {
            // navigation title
            self.navigationTitlePublished = "Title - Updated"
            
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
            self.navigationButtonsPublished = [menuButton, favoriteButton]
        }
    }
}

extension SwiftUIScreenViewModel: SwiftUIScreenViewModelProtocol { }

extension SwiftUIScreenViewModel: NavigationBar.DataSource {
    var navigtionTitle: Published<String>.Publisher {
        return $navigationTitlePublished
    }
    
    var navigationButtons: Published<[NavigationBar.ButtonType]>.Publisher {
        return $navigationButtonsPublished
    }
}
