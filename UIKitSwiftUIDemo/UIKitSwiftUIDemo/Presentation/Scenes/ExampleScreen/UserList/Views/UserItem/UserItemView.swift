//
//  UserItemView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/17.
//

import SwiftUI
import AtomicDS

struct UserItemView<ViewModel: UserItemViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack(alignment: .center,
               spacing: .init(spacing: .large)) {
            avatar
            labels
        }
       .padding(.all, .init(spacing: .large))
    }
    
    var avatar: some View {
        AvatarView(url: viewModel.avatarURL,
                   style: .medium)
    }
    
    var labels: some View {
        VStack(alignment: .leading,
               spacing: .init(spacing: .extraSmall)) {
            TextView(viewModel.name,
                     style: .headingExtraSmallDarkGrayDarkest)
            if let email = viewModel.email {
                TextView(email,
                         style: .bodySmallDarkGrayLight)
            }
        }
    }
}

#Preview {
    NavigationView {
        List {
            UserItemView(viewModel: UserItemViewModel(userModel: .init(id: UUID().uuidString,
                                                                       avatarURL: nil,
                                                                       name: "Allan Canare",
                                                                       email: "me@allancanare.com")))
        }
    }
}
