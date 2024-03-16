//
//  UserListViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/14.
//

import Foundation

protocol UserListViewModelProtocol: ObservableObject {
    
}

final class UserListViewModel {
    @Published private var navigationTitlePublished = "UserList"
    @Published private var navigationButtonsPublished = [NavigationBar.ButtonType]()
}

extension UserListViewModel: UserListViewModelProtocol { }

extension UserListViewModel: NavigationBar.DataSource {
    var navigtionTitle: Published<String>.Publisher {
        return $navigationTitlePublished
    }
    
    var navigationButtons: Published<[NavigationBar.ButtonType]>.Publisher {
        return $navigationButtonsPublished
    }
}
