//
//  AppCoordinatorTests.swift
//  homeTask1_MVVMC_v2Tests
//
//  Created by Maksym Korostelov on 12/9/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import XCTest
@testable import homeTask1_MVVMC_v2

class AppCoordinatorTests: XCTestCase {
    private final class MockLoginCoordinator: LoginCoordinatorProtocol {
        var startedExpectation: XCTestExpectation!
        
        func loginViewModelDidLogin() {
            delegate?.loginCoordinatorDidFinish()
        }
        
        var delegate: LoginCoordinatorDelegate?
        
        func start() {
            startedExpectation.fulfill()
        }
    }
    
    private final class MockListCoordinator: ListCoordinatorProtocol {
        var startedExpectation: XCTestExpectation!
        var delegate: LoginCoordinatorDelegate?
        
        func start() {
            startedExpectation.fulfill()
        }
        
        
    }
    
    func testStartLogin() {
        let expectation = self.expectation(description: "Login flow is started.")
        let mockLoginCoordinator = MockLoginCoordinator()
        mockLoginCoordinator.startedExpectation = expectation
        
        let appCoordinator = AppCoordinator()
        appCoordinator.startLogin(with: mockLoginCoordinator)
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testStartList() {
        let expectation = self.expectation(description: "List flow is started.")
        let mockListCoordinator = MockListCoordinator()
        mockListCoordinator.startedExpectation = expectation
        
        let appCoordinator = AppCoordinator()
        appCoordinator.startList(with: mockListCoordinator)
        waitForExpectations(timeout: 1, handler: nil)
    }
}
