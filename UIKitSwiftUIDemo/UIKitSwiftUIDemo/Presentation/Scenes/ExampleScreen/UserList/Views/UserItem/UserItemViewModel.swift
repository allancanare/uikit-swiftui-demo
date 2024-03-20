//
//  UserItemViewModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/17.
//

import Foundation
import Combine

protocol UserItemViewModelProtocol: ObservableObject {
    var id: UserID { get }
    var avatarURL: URL? { get }
    var name: String { get }
    var email: String? { get }
    
    func update()
}

final class UserItemViewModel {
    @Published var avatarURL: URL?
    @Published var name = ""
    @Published var email: String?
    
    @Published private var userModel: UserModel
    private var cancellables = Set<AnyCancellable>()
    
    init(userModel: UserModel) {
        self.userModel = userModel
        setupBindings()
    }
}

// MARK: - UserItemViewModelProtocol
extension UserItemViewModel: UserItemViewModelProtocol {
    var id: UserID {
        return userModel.id
    }
    
    func update() {
        userModel = .init(id: userModel.id,
                          avatarURL: nil,
                          name: name + " updated",
                          email: "updated to a very long line that might require multiple lines of text. Now, most likely this item has three lines of text or more." + (email ?? ""))
    }
}

// MARK: - Private Functions
private extension UserItemViewModel {
    func setupBindings() {
        $userModel
            .sink { [weak self] userModel in
                self?.avatarURL = userModel.avatarURL
                self?.name = userModel.name
                self?.email = userModel.email
            }
            .store(in: &cancellables)
    }
}
