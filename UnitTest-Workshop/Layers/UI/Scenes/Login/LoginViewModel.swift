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
    
    init(
        initialState: LoginViewState = .init()
    ) {
        state = initialState
    }
    
    func login() {
        state.isLoggingIn = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.state.isLoggingIn = false
            self.state.isShowingErrorAlert = true
        }
    }
}
