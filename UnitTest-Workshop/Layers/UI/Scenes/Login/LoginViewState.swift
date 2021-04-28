//
//  LoginViewState.swift
//  UnitTest-Workshop
//
//  Created by Vinicius Alencar on 4/26/21.
//

import Foundation

struct LoginViewState: Equatable {
    var email = ""
    var password = ""
    var isLoggingIn = false
    var isShowingErrorAlert = false
}



extension LoginViewState {
    var canSubmit: Bool {
        email.isEmpty == false
            && password.isEmpty == false
    }
    var footerMessage: String {
        isLoggingIn ? "Fazendo Login..." : ""
    }
}
