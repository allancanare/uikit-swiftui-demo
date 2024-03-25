//
//  UserListViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/14.
//

import Foundation
import UIKit
import SwiftUI

protocol UserListViewModelDelegate: AnyObject {
    func userListViewModelWillClose(_ viewModel: any UserListViewModelProtocol)
}

protocol UserListViewModelProtocol: ObservableObject {
    var items: [UserList.SectionType] { get }
}

final class UserListViewModel {
    // MARK: Public Properties
    weak var delegate: UserListViewModelDelegate?
    @Published var items = [UserList.SectionType]()
    
    // MARK: Private Properties
    private var users = [UserItemViewModel]()
    private let navigationBarDataSource: NavigationBarDataSource
    private var currentItemCount = 0
    private var countIncrement = 1
    
    init(navigationBarDataSource: NavigationBarDataSource) {
        self.navigationBarDataSource = navigationBarDataSource
        generateNavigationBarData()
        add()
    }
}

// MARK: - UserListViewModelProtocol
extension UserListViewModel: UserListViewModelProtocol { }

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
        
        let menuData = NavigationBar.ButtonType.MenuData.init(icon: UIImage(systemName: "ellipsis")!,
                                                              items: [update, shuffle, shuffleExistingItems, add, remove])
        navigationBarDataSource.setRightBarButtons([.menu(menuData)])
    }
    
    func shuffle() {
        let viewModels = self.generateAndShuffle()
        Task { @MainActor in
            self.users = viewModels
            self.generateSections(fromUsers: self.users)
        }
    }
    
    func shuffleExistingItems() {
        Task { @MainActor in
            self.users = self.users.shuffled()
            self.generateSections(fromUsers: self.users)
        }
    }
    
    func add() {
        let itemsToAdd = generateUsers(start: currentItemCount + 1,
                                       count: currentItemCount + countIncrement)
        currentItemCount += countIncrement
        Task { @MainActor in
            self.users.append(contentsOf: itemsToAdd)
            self.generateSections(fromUsers: self.users)
        }
    }
    
    func removeRandomItem() {
        guard let idx = (0 ..< users.count).randomElement() else { return }
        users.remove(at: idx)
        generateSections(fromUsers: users)
    }
    
    func update() {
        users.randomElement()?.update()
        generateSections(fromUsers: users)
    }
    
    func generateAndShuffle() -> [UserItemViewModel] {
        guard currentItemCount > 0 else { return [] }
        return generateUsers(start: 1,
                             count: currentItemCount).shuffled()
    }
    
    func generateUsers(start: Int,
                       count: Int) -> [UserItemViewModel] {
        return (start...count).map { idx in
            return UserItemViewModel(userModel: .init(id: "\(idx)",
                                                      avatarURL: URL(string: ["", "https://workfromcafe.app/assets/appicon.png"].randomElement()!),
                                                      name: "User \(idx)",
                                                      email: "user\(idx)@gmail.com"))
        }
    }
    
    func generateSections(fromUsers users: [UserItemViewModel]) {
        let userSectionHeader: ListData.HeaderType
        userSectionHeader = .titleWithAction(.init(id: 2,
                                                   icon: .profile,
                                                   title: "Users",
                                                   action: .init(icon: .add) { [weak self] in
           self?.add()
       }))
        
        let noteSectionHeader: ListData.HeaderType
        noteSectionHeader = .titleWithAction(.init(id: 3,
                                                   icon: .create,
                                                   title: "Notes",
                                                   action: nil))
        
        items = [.user(.init(headerType: userSectionHeader,
                             rows: users.map { AnyUserItemViewModelProtocol(viewModel: $0) })),
                 .note(.init(headerType: noteSectionHeader,
                             rows: generateNoteItemViewModel().map { AnyNoteItemViewModelProtocol(viewModel: $0) }))]
    }
    
    func generateNoteItemViewModel() -> [NoteItemViewModel] {
        return (1...5).map { idx in
            NoteItemViewModel(noteModel: .init(id: "\(idx)",
                                               title: "Note \(idx)",
                                               content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Tempor id eu nisl nunc mi ipsum faucibus vitae aliquet."))
        }
    }
}

// MARK: - NavigationBarDataSourceDelegate
extension UserListViewModel: NavigationBarDataSourceDelegate {
    func navigationBarDataSourceWillDismiss(_ navigationBarDataSource: NavigationBarDataSource) {
        delegate?.userListViewModelWillClose(self)
    }
}
