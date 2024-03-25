//
//  UserListView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/14.
//

import SwiftUI

struct UserListView<ViewModel: UserListViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    @State var searchKeyword = ""
    var body: some View {
        List {
            ForEach(viewModel.items, id: \.id) { sectionType in
                Section {
                    generateSectionRows(fromSectionType: sectionType)
                } header: {
                    generateSectionHeader(fromSectionType: sectionType)
                }
            }
        }
        .animation(.default, value: UUID())
        .listStyle(.grouped)
    }
    
    @ViewBuilder
    func generateSectionRows(fromSectionType sectionType: UserList.SectionType) -> some View {
        switch sectionType {
        case .user(let sectionData):
            ForEach(sectionData.rows, id: \.viewModel.id) { userViewModel in
                UserItemView(viewModel: userViewModel.viewModel)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
            }
        case .group(let sectionData):
            ForEach(sectionData.rows, id: \.viewModel.id) { userViewModel in
                UserItemView(viewModel: userViewModel.viewModel)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
            }
        case .note(let sectionData):
            ForEach(sectionData.rows, id: \.viewModel.id) { noteViewModel in
                NoteItemView(viewModel: noteViewModel.viewModel)
                    .listRowSeparator(.hidden)
            }
        }
    }
    
    @ViewBuilder
    func generateSectionHeader(fromSectionType sectionType: UserList.SectionType) -> some View {
        switch sectionType {
        case .user(let sectionData):
            generateSectionHeader(fromHeaderType: sectionData.headerType)
        case .group(let sectionData):
            generateSectionHeader(fromHeaderType: sectionData.headerType)
        case .note(let sectionData):
            generateSectionHeader(fromHeaderType: sectionData.headerType)
        }
    }
    
    @ViewBuilder
    func generateSectionHeader(fromHeaderType headerType: ListData.HeaderType) -> some View {
        switch headerType {
        case .titleWithAction(let titleWithActionData):
            generateTitleWithActionHeader(fromTitleWithActionData: titleWithActionData)
        }
    }
    
    func generateTitleWithActionHeader(fromTitleWithActionData titleWithActionData: ListData.HeaderType.TitleWithActionData) -> some View {
        HStack {
            if let icon = titleWithActionData.icon {
                view(fromIcon: icon)
            }
            Text(titleWithActionData.title)
            Spacer()
            if let actionData = titleWithActionData.action {
                view(fromActionData: actionData)
            }
        }
    }
    
    func view(fromIcon icon: Image) -> some View {
        icon
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 24, height: 24)
    }
    
    func view(fromActionData actionData: ListData.HeaderType.TitleWithActionData.ActionData) -> some View {
        actionData.icon
             .resizable()
             .frame(width: 24, height: 24)
             .onTapGesture {
                 actionData.action()
             }
    }
}

#Preview {
    UserListView(viewModel: UserListViewModel(navigationBarDataSource: NavigationBarDataSource()))
}
