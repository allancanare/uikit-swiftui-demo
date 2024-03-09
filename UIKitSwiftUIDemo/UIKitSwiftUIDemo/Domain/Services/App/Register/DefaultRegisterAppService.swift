//
//  DefaultRegisterAppService.swift
//  UIKitSwiftUIDemo
//
//  Created by Allan Canare on 2024/02/25.
//

import Foundation

final class DefaultRegisterAppService {
    let networkService: RegisterNetworkService
    
    init(networkService: RegisterNetworkService) {
        self.networkService = networkService
    }
}

extension DefaultRegisterAppService: RegisterAppService {
    func register(_ input: RegisterInput,
                  completionHandler: @escaping (Result<UserModel, Error>) -> Void) {
        networkService.register(input,
                                completionHandler: completionHandler)
    }
}
