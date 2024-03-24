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
        case user(ListData.SectionData<AnyUserItemViewModelProtocol<UserItemViewModel>>)
        case group(ListData.SectionData<AnyUserItemViewModelProtocol<UserItemViewModel>>)
        
        var id: ListData.SectionID {
            switch self {
            case .user(let sectionData):
                return sectionData.headerType.id
            case .group(let sectionData):
                return sectionData.headerType.id
            }
        }
    }
}
