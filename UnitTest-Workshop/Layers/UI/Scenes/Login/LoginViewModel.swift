//
//  LoginViewModel.swift
//  UnitTest-Workshop
//
//  Created by Vinicius Alencar on 4/26/21.
//

import Foundation
import SwiftUI

final class LoginViewModel: ObservableObject {
    @Published private(set) var state: LoginViewState
    private let service: LoginService
    private let loginDidSucceed: () -> Void //Não precisa do @escaping pois está subentendido que está armazenado
    
    init(
        initialState: LoginViewState = .init(),
        service: LoginService,
        loginDidSucceed: @escaping () -> Void
    ) {
        state = initialState
        self.service = service
        self.loginDidSucceed = loginDidSucceed
    }
    
    var bindings: (
        email: Binding<String>,
        password: Binding<String>,
        isShowingErrorAlert: Binding<Bool>
    ) {
        (
            email: Binding(get: {self.state.email}, set: {self.state.email = $0}),
            password: Binding(get: {self.state.password}, set: {self.state.password = $0}),
            isShowingErrorAlert: Binding(get: {self.state.isShowingErrorAlert}, set: {self.state.isShowingErrorAlert = $0})
        )
    }

    func login() {
        state.isLoggingIn = true
        service.login(email: state.email, password: state.password) { [weak self] (error) in
            if error == nil {
                self?.loginDidSucceed()
            } else {
                self?.state.isLoggingIn = false
                self?.state.isShowingErrorAlert = true
            }
             
        }
    }
}
