//
//  UserModel.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/25.
//

import Foundation

typealias UserID = String

struct UserModel {
    let id: UserID
    let avatarURL: URL?
    let name: String
    let email: String
}
