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
        .listStyle(.plain)
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
        case .note(let sectionData):
            generateSectionHeader(fromHeaderType: sectionData.headerType)
        }
    }
    
    @ViewBuilder
    func generateSectionHeader(fromHeaderType headerType: ListData.HeaderType) -> some View {
        switch headerType {
        case .titleWithAction(let titleWithActionData):
            SectionHeaderView(titleWithActionData: titleWithActionData)
        }
    }
}

#Preview {
    UserListView(viewModel: UserListViewModel(navigationBarDataSource: NavigationBarDataSource()))
}
