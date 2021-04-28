//
//  FailWithDelayLoginService.swift
//  UnitTest-Workshop
//
//  Created by Vinicius Alencar on 4/28/21.
//

import Foundation

struct FailWithDelayLoginService: LoginService{
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            completion(NSError(domain: "", code: 1, userInfo: nil))
        }
    }
}
