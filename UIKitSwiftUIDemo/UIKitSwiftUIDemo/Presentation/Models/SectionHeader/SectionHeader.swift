//
//  SectionHeader.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/20.
//

import Foundation
import SwiftUI

enum SectionHeader { }

extension SectionHeader {
    enum HeaderType {
        case title(TitleData)
        case titleWithAction(TitleWithActionData)
        
        var id: SectionHeaderID {
            switch self {
            case .title(let titleData):
                return titleData.id
            case .titleWithAction(let titleWithActionData):
                return titleWithActionData.id
            }
        }
    }
}

extension SectionHeader {
    typealias SectionHeaderID = Int
    
    struct TitleData {
        let id: SectionHeaderID
        let title: String
    }
    
    struct TitleWithActionData {
        let id: SectionHeaderID
        let icon: Image?
        let title: String
        let action: ActionData
    }
}

extension SectionHeader.TitleWithActionData {
    struct ActionData {
        let icon: Image
        let action: () -> Void
    }
}
