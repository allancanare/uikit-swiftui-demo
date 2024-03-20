//
//  DefaultRegisterNetworkService.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/25.
//

import Foundation

final class DefaultRegisterNetworkService {
    
}

extension DefaultRegisterNetworkService: RegisterNetworkService {
    func register(_ input: RegisterInput,
                  completionHandler: @escaping (Result<UserModel, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            completionHandler(.success(.init(id: UUID().uuidString,
                                             avatarURL: nil,
                                             name: input.name,
                                             email: input.email)))
        }
    }
}
