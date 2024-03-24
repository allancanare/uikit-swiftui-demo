//
//  UserListViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/14.
//

import Foundation
import UIKit

protocol UserListViewModelDelegate: AnyObject {
    func userListViewModelWillClose(_ viewModel: any UserListViewModelProtocol)
}

protocol UserListViewModelProtocol: ObservableObject {
    // Necessary to not use `[any UserItemViewModelProtocol]`
    associatedtype ItemViewModelProtocol: UserItemViewModelProtocol
    var users: [ItemViewModelProtocol] { get }
    var items: [AnyUserItemViewModelProtocol<UserItemViewModel>] { get }
}

final class UserListViewModel {
    // MARK: Public Properties
    weak var delegate: UserListViewModelDelegate?
    
    @Published var users = [UserItemViewModel]()
    
    // MARK: Private Properties
    private let navigationBarDataSource: NavigationBarDataSource
    private var currentItemCount = 0
    private var countIncrement = 5
    
    init(navigationBarDataSource: NavigationBarDataSource) {
        self.navigationBarDataSource = navigationBarDataSource
        generateNavigationBarData()
    }
}

// MARK: - UserListViewModelProtocol
extension UserListViewModel: UserListViewModelProtocol {
    var items: [AnyUserItemViewModelProtocol<UserItemViewModel>] {
        return []
    }
}

// MARK: - Private Functions
private extension UserListViewModel {
    func generateNavigationBarData() {
        navigationBarDataSource.setTitle("User List")
        
        let update: NavigationBar.ButtonType.MenuData.ItemData
        update = .init(title: "Update Random Item",
                       icon: UIImage(systemName: "pencil")!) { [weak self] in
            self?.update()
        }
        
        let shuffle: NavigationBar.ButtonType.MenuData.ItemData
        shuffle = .init(title: "Shuffle And Reset Items",
                        icon: UIImage(systemName: "shuffle")!) { [weak self] in
            self?.shuffle()
        }
        
        let shuffleExistingItems: NavigationBar.ButtonType.MenuData.ItemData
        shuffleExistingItems = .init(title: "Shuffle Existing Items",
                                     icon: UIImage(systemName: "shuffle")!) { [weak self] in
            self?.shuffleExistingItems()
        }
        
        let add: NavigationBar.ButtonType.MenuData.ItemData
        add = .init(title: "Add Items",
                    icon: UIImage(systemName: "plus")!) { [weak self] in
            self?.add()
        }
        
        let remove: NavigationBar.ButtonType.MenuData.ItemData
        remove = .init(title: "Remove Random Item",
                       icon: UIImage(systemName: "trash")!) { [weak self] in
            self?.removeRandomItem()
        }
        
        let menuData = NavigationBar.ButtonType.MenuData.init(icon: UIImage(systemName: "square.and.arrow.up")!,
                                                              items: [update, shuffle, shuffleExistingItems, add, remove])
        navigationBarDataSource.setRightBarButtons([.menu(menuData)])
    }
    
    func shuffle() {
        let viewModels = self.generateAndShuffle()
        Task { @MainActor in
            self.users = viewModels
        }
    }
    
    func shuffleExistingItems() {
        Task { @MainActor in
            self.users = self.users.shuffled()
        }
    }
    
    func add() {
        let itemsToAdd = generateUsers(start: currentItemCount + 1,
                                       count: currentItemCount + countIncrement)
        currentItemCount += countIncrement
        Task { @MainActor in
            self.users.append(contentsOf: itemsToAdd)
        }
    }
    
    func removeRandomItem() {
        guard let idx = (0 ..< users.count).randomElement() else { return }
        users.remove(at: idx)
    }
    
    func update() {
        users.randomElement()?.update()
    }
    
    func generateAndShuffle() -> [UserItemViewModel] {
        guard currentItemCount > 0 else { return [] }
        return generateUsers(start: 1,
                             count: currentItemCount).shuffled()
    }
    
    func generateUsers(start: Int,
                       count: Int) -> [UserItemViewModel] {
        return (start...count).map { idx in
            UserItemViewModel(userModel: .init(id: "\(idx)",
                                               avatarURL: nil,
                                               name: "User \(idx)",
                                               email: "user\(idx)@gmail.com"))
        }
    }
}

// MARK: - NavigationBarDataSourceDelegate
extension UserListViewModel: NavigationBarDataSourceDelegate {
    func navigationBarDataSourceWillDismiss(_ navigationBarDataSource: NavigationBarDataSource) {
        delegate?.userListViewModelWillClose(self)
    }
}
