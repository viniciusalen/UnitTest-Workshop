//
//  LoginTests.swift
//  UnitTest-WorkshopTests
//
//  Created by Vinicius Alencar on 4/28/21.
//

@testable import UnitTest_Workshop
import XCTest

class LoginTests: XCTestCase {

    private var viewModel: LoginViewModel! // Subject under test - "Centro de tudo, o que está sendo testado"
    private var service: LoginServiceMock!
    private var didCallLoginDidSucceed: Bool!
    
    override func setUp() {
        super.setUp()
        
        //Controlar nosso serviço
        didCallLoginDidSucceed = false
        service = .init()
        viewModel = .init(service: service, loginDidSucceed: {[weak self] in
            self?.didCallLoginDidSucceed = true
        })
    }
    
    // Testando se view model está inicializando conforme o state inicial
    func testDefaultInitialState(){
        XCTAssertEqual(viewModel.state, LoginViewState(
                    email: "",
                    password: "",
                    isLoggingIn: false,
                    isShowingErrorAlert: false)
        )
        
        XCTAssertFalse(viewModel.state.canSubmit)
        XCTAssert(viewModel.state.footerMessage.isEmpty)
    }
    
    // Testando o caso de sucesso para logar
    func testSuccessfullLoginFlow(){
        
        //fingir que digitou um email válido
        viewModel.bindings.email.wrappedValue = "vini.alencar@gmail.com"
        viewModel.bindings.password.wrappedValue = "x"
        XCTAssert(viewModel.state.canSubmit)
        XCTAssert(viewModel.state.footerMessage.isEmpty)
        
        viewModel.login()
        
        XCTAssertEqual(viewModel.state, LoginViewState(
                    email: "vini.alencar@gmail.com",
                    password: "x",
                    isLoggingIn: true,
                    isShowingErrorAlert: false
            )
        )
        XCTAssertFalse(viewModel.state.canSubmit)
        XCTAssertEqual(viewModel.state.footerMessage, LoginViewState.isLoggingInFooter)
        
        //Se assegurar que o nosso servico está recebendo o que o usuario enviou
        XCTAssertEqual(service.lastReceivedEmail, "vini.alencar@gmail.com")
        XCTAssertEqual(service.lastReceivedPassword, "x")
        
        service.completion?(nil)
        XCTAssert(didCallLoginDidSucceed)
    }
    
    // Testando o caso de sucesso para logar
    func testUnsuccessfullLoginFlow(){
        //fingir que digitou um email válido
        viewModel.bindings.email.wrappedValue = "vini.alencar@gmail.com"
        viewModel.bindings.password.wrappedValue = "x"
        XCTAssert(viewModel.state.canSubmit)
        XCTAssert(viewModel.state.footerMessage.isEmpty)
        
        viewModel.login()
        
        XCTAssertEqual(viewModel.state, LoginViewState(
                    email: "vini.alencar@gmail.com",
                    password: "x",
                    isLoggingIn: true,
                    isShowingErrorAlert: false
            )
        )
        XCTAssertFalse(viewModel.state.canSubmit)
        XCTAssertEqual(viewModel.state.footerMessage, LoginViewState.isLoggingInFooter)
        
        //Se assegurar que o nosso servico está recebendo o que o usuario enviou
        XCTAssertEqual(service.lastReceivedEmail, "vini.alencar@gmail.com")
        XCTAssertEqual(service.lastReceivedPassword, "x")
        
        struct FakeError: Error {}
        service.completion?(FakeError())
        XCTAssertEqual(viewModel.state, LoginViewState(
                    email: "vini.alencar@gmail.com",
                    password: "x",
                    isLoggingIn: false,
                    isShowingErrorAlert: true
            )
        )
        XCTAssert(viewModel.state.canSubmit)
        XCTAssert(viewModel.state.footerMessage.isEmpty)
        
        XCTAssertFalse(didCallLoginDidSucceed)
    }
}

private final class LoginServiceMock: LoginService {
    var lastReceivedEmail: String?
    var lastReceivedPassword: String?
    var completion: ((Error?) -> Void)?

    func login(
        email: String,
        password: String,
        completion: @escaping (Error?) -> Void
    ) {
        lastReceivedEmail = email
        lastReceivedPassword = password
        self.completion = completion
    }
}
