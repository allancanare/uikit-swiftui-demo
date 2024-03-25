//
//  SectionHeaderView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/25.
//

import SwiftUI
import AtomicDS

struct SectionHeaderView: View {
    let titleWithActionData: ListData.HeaderType.TitleWithActionData
    
    var body: some View {
        HStack(spacing: .init(spacing: .small)) {
            if let icon = titleWithActionData.icon {
                IconView(icon,
                         style: .mediumDarkGrayDarkest)
            }
            TextView(titleWithActionData.title,
                     style: .headingSmallDarkGrayDarkest)
            Spacer()
            if let actionData = titleWithActionData.action {
                IconView(actionData.icon,
                         style: .mediumHighlightDarkest)
                     .onTapGesture {
                         actionData.action()
                     }
            }
        }
    }
}

#Preview {
    List {
        SectionHeaderView(titleWithActionData: .init(id: 1,
                                                     icon: .profile,
                                                     title: "Users",
                                                     action: .init(icon: .add,
                                                                   action: { })))
    }
}