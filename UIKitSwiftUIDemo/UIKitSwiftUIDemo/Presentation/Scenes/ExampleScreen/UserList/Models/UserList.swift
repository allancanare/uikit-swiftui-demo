//
//  UserList.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/20.
//

import Foundation
import SwiftUI

enum UserList { }

extension UserList {
    enum SectionType {
        case user([AnyUserItemViewModelProtocol<UserItemViewModel>])
    }
}
