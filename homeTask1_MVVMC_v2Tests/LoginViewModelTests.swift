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
    var testViewModel: LoginViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        
        let model = MockLoginModel()
        let networkServise = MockNetworkService()
        let coordinator = MockLoginCoordinator()
        
        testViewModel = LoginViewModel(
            model: model,
            networkServise: networkServise,
            coordinator: coordinator)
    }
    
    override func tearDown() {
        super.tearDown()
        
        testViewModel = nil
    }
    
    private final class MockLoginModel: LoginModelProtocol {
        var viewModel: LoginViewModelProtocol?
        
        var userName: String = ""
        var password: String = ""
    }
    
    final private class MockLoginView: LoginViewProtocol {
        var expectation: XCTestExpectation?
        var viewModel: LoginViewModelProtocol!
        
        func errorMessageDidChange() {
            expectation?.fulfill()
        }
        func passwordDidChange() {
            
        }
        func userNameDidChange() {
            
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
        XCTAssertEqual("", testViewModel.userName)
        XCTAssertEqual("", testViewModel.password)
        XCTAssertEqual("", testViewModel.errorMessage)
        XCTAssertNil(testViewModel.view)
    }
    
    func testUserName() {
        let expectedValue = "user"
        let mockModel = MockLoginModel()
        mockModel.userName = expectedValue
        let vm = LoginViewModel(
            model: mockModel,
            networkServise: MockNetworkService(),
            coordinator: MockLoginCoordinator())
        XCTAssertEqual(expectedValue, vm.userName)
    }
    
    func testPassword() {
        let expectedValue = "password"
        let mockModel = MockLoginModel()
        mockModel.userName = expectedValue
        let vm = LoginViewModel(
            model: mockModel,
            networkServise: MockNetworkService(),
            coordinator: MockLoginCoordinator())
        vm.password = expectedValue
        XCTAssertEqual("password", vm.password)
    }
    
    func testFailureLoginMessage() {
        let expectation = self.expectation(description: "Error message is set.")
        let mockLoginView = MockLoginView()
        mockLoginView.expectation = expectation
        
        testViewModel.view = mockLoginView
        testViewModel.userName = "userX"
        testViewModel.password = "passwordX"
        testViewModel.loginUser()
        
        XCTAssertEqual("Invalid User Name or Password.", testViewModel.errorMessage)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSuccessLogin() {
        let expectation = self.expectation(description: "User is logged in.")
        let coordinator = MockLoginCoordinator()
        coordinator.expectation = expectation
        
        let vm = LoginViewModel(
            model: MockLoginModel(),
            networkServise: MockNetworkService(),
            coordinator: coordinator)
        vm.userName = "user"
        vm.password = "password"
        vm.loginUser()
        waitForExpectations(timeout: 1, handler: nil)
    }
}
