//
//  LoginViewModelTests.swift
//  homeTask1_MVVMC_v2Tests
//
//  Created by Maksym Korostelov on 12/8/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import XCTest
@testable import homeTask1_MVVMC_v2

class LoginViewModelTests: XCTestCase {
    private final class MockLoginModel: LoginModelProtocol {
        var userName: String = ""
        var password: String = ""
    }
    
    final private class MockLoginView: LoginViewProtocol {
        var expectation: XCTestExpectation?
        var viewModel: LoginViewModelProtocol!
        
        func errorMessageDidChange(message: String) {
            expectation?.fulfill()
        }
    }
    
    private final class MockNetworkService: NetworkService {
        override func requestLoginData(userName: String, password: String, completionHandler: @escaping (Result<Bool, LoginError>) -> Void) {
            guard userName == "user" && password == "password" else {
                completionHandler(.failure(LoginError.wrongCredentials))
                return
            }
            completionHandler(.success(true))
        }
    }
    
    private final class MockLoginCoordinator: LoginCoordinatorProtocol {
        var expectation: XCTestExpectation?
        var delegate: LoginCoordinatorDelegate?
        
        func loginViewModelDidLogin() {
            expectation?.fulfill()
        }
        
        func start() {
            
        }
    }
    
    func testInitialDefaults() {
        let vm = LoginViewModel()
        XCTAssertEqual("", vm.userName)
        XCTAssertEqual("", vm.password)
        XCTAssertEqual("", vm.errorMessage)
        XCTAssertNil(vm.view)
        XCTAssertNil(vm.model)
        XCTAssertNil(vm.coordinator)
    }
    
    func testUserName() {
        let expectedValue = "user"
        let vm = LoginViewModel()
        vm.model = MockLoginModel()
        vm.userName = expectedValue
        XCTAssertEqual(expectedValue, vm.userName)
        XCTAssertEqual(expectedValue, vm.model?.userName)
    }
    
    func testPassword() {
        let vm = LoginViewModel()
        vm.model = MockLoginModel()
        vm.password = "password"
        XCTAssertEqual("password", vm.password)
        XCTAssertEqual("password", vm.model?.password)
    }
    
    func testFailureLoginMessage() {
        let expectation = self.expectation(description: "Error message is set.")
        let mockLoginView = MockLoginView()
        mockLoginView.expectation = expectation
        
        let vm = LoginViewModel()
        vm.view = mockLoginView
        vm.model = MockLoginModel()
        vm.networkService = MockNetworkService()
        vm.userName = "userX"
        vm.password = "passwordX"
        vm.loginUser()
        
        XCTAssertEqual("Invalid User Name or Password.", vm.errorMessage)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSuccessLogin() {
        let expectation = self.expectation(description: "User is logged in.")
        let coordinator = MockLoginCoordinator()
        coordinator.expectation = expectation
        
        let vm = LoginViewModel()
        vm.coordinator = coordinator
        vm.model = MockLoginModel()
        vm.networkService = MockNetworkService()
        vm.userName = "user"
        vm.password = "password"
        vm.loginUser()
        waitForExpectations(timeout: 1, handler: nil)
    }
}
