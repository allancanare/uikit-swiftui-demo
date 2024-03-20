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
        List(viewModel.users, id: \.id) { userViewModel in
            UserItemView(viewModel: userViewModel)
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
        .animation(.default)
        .listStyle(.plain)
        .padding(.horizontal, 8)
    }
}

#Preview {
    UserListView(viewModel: UserListViewModel(navigationBarDataSource: NavigationBarDataSource()))
}
