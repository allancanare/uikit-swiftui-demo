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
        case note(ListData.SectionData<AnyNoteItemViewModelProtocol<NoteItemViewModel>>)
        
        var id: ListData.SectionID {
            switch self {
            case .user(let sectionData):
                return sectionData.headerType.id
            case .note(let sectionData):
                return sectionData.headerType.id
            }
        }
    }
}
