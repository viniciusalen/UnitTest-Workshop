//
//  LoginService.swift
//  UnitTest-Workshop
//
//  Created by Vinicius Alencar on 4/28/21.
//

import Foundation
protocol LoginService {
    func login(email: String, password: String, completion: @escaping (Error?) -> Void)
}

struct EmptyLoginService: LoginService {
    func login(email: String, password: String, completion: @escaping (Error?) -> Void){}
}
