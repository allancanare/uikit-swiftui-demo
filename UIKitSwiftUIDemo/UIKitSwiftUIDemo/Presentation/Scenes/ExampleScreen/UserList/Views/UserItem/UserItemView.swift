//
//  UserItemView.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/03/17.
//

import SwiftUI

struct UserItemView<ViewModel: UserItemViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack(alignment: .center,
               spacing: 16) {
            avatar
            labels
        }
       .padding(.all, 16)
    }
    
    var avatar: some View {
        AsyncImage(url: viewModel.avatarURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
            default:
                placeholder
            }
        }
        .frame(width: 40, height: 40)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    var placeholder: some View {
        ZStack {
            Color.gray
            VStack {
                Spacer()
                Image(systemName: "person.fill")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .frame(width: 32, height: 32)
            }
        }
    }
    
    var labels: some View {
        VStack(alignment: .leading,
               spacing: 2) {
            Text(viewModel.name)
                .font(.title3)
            if let email = viewModel.email {
                Text(email)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    UserItemView(viewModel: UserItemViewModel(userModel: .init(id: UUID().uuidString, 
                                                               avatarURL: nil,
                                                               name: "Allan Canare",
                                                               email: "me@allancanare.com")))
}
