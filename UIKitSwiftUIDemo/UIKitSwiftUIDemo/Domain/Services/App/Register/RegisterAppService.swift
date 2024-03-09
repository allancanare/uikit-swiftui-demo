//
//  RegisterAppService.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/25.
//

import Foundation

protocol RegisterAppService {
    func register(_ input: RegisterInput,
                  completionHandler: @escaping (Result<UserModel, Error>) -> Void)
}

struct RegisterInput {
    let name: String
    let email: String
    let password: String
}
