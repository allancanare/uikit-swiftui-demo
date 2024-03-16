//
//  UserListView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/14.
//

import SwiftUI

struct UserListView<ViewModel: UserListViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        Text("User List View")
    }
}

#Preview {
    UserListView(viewModel: UserListViewModel())
}
