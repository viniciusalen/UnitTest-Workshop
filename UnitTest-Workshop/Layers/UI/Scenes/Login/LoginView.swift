//
//  ContentView.swift
//  UnitTest-Workshop
//
//  Created by Vinicius Alencar on 4/26/21.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var model : LoginViewModel
    
    init(model: LoginViewModel) {
        self.model = model
    }
    
    var body: some View {
        
        
        Form {
            Section(footer: formFooter) {
                TextField("email", text: model.bindings.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                SecureField("senha", text: model.bindings.password)
            }
        }
        .navigationBarItems(trailing: submitButton)
        .navigationBarTitle("Identifique-se")
        .disabled(model.state.isLoggingIn)
        .alert(isPresented: model.bindings.isShowingErrorAlert) { () -> Alert in
            Alert(title: Text("Erro ao fazer o login"),
                  message: Text("Verifique seu email e senha e tente novamente"))
        }
        
        
        
    }
    
    private var submitButton: some View {
        Button(action: model.login) {
            Text("Entrar")
        }
        .disabled(model.state.canSubmit == false)
    }

    private var formFooter: some View {
        Text(model.state.footerMessage)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(model: .init())
    }
}
