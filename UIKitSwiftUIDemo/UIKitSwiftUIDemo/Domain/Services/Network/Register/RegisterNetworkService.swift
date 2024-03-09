//
//  RegisterNetworkService.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/25.
//

import Foundation

protocol RegisterNetworkService {
    func register(_ input: RegisterInput,
                  completionHandler: @escaping (Result<UserModel, Error>) -> Void)
}
