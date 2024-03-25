//
//  ListData.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/20.
//

import Foundation
import SwiftUI
import AtomicDS

enum ListData { }

extension ListData {
    typealias SectionID = Int
}

extension ListData {
    enum HeaderType {
        case titleWithAction(TitleWithActionData)
        
        var id: SectionID {
            switch self {
            case .titleWithAction(let titleWithActionData):
                return titleWithActionData.id
            }
        }
    }
}

extension ListData.HeaderType {
    struct TitleWithActionData {
        let id: ListData.SectionID
        let icon: Icon?
        let title: String
        let action: ActionData?
    }
}

extension ListData.HeaderType.TitleWithActionData {
    struct ActionData {
        let icon: Icon
        let action: () -> Void
    }
}

extension ListData {
    struct SectionData<AnyRowViewModelProtocol> {
        let headerType: HeaderType
        let rows: [AnyRowViewModelProtocol]
    }
}
