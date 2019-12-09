//
//  ListViewModel.swift
//  homeTask1_MVVMC_v2Tests
//
//  Created by Maksym Korostelov on 12/8/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

import XCTest
@testable import homeTask1_MVVMC_v2

class ListViewModelTests: XCTestCase {
    private final class MockNetworkService: NetworkService {        
        override func requestData(url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
            let str = "abc\ndef\ngh\n"
            guard let data = str.data(using: .utf8) else {
                completionHandler(.failure(NSError()))
                return
            }
            completionHandler(.success(data))
        }
    }
    
    private final class MockListModel: ListModelProtocol {
        var randomList: [String] = []
    }
    
    func testInitialDefaults() {
        let vm = ListViewModel()
        XCTAssertEqual(0, vm.numberOfRows)
        XCTAssertNil(vm.randomList)
        XCTAssertNil(vm.view)
        XCTAssertNil(vm.model)
        XCTAssertNil(vm.coordinator)
    }

    func testDataLoadedAndParsed() {
        let expectedResult = ["abc", "def", "gh"]
        let vm = ListViewModel()
        vm.networkServise = MockNetworkService()
        vm.model = MockListModel()
        XCTAssertEqual(expectedResult, vm.randomList)
        XCTAssertEqual(expectedResult, vm.model?.randomList)
    }
    
    func testNumberOfRows() {
        let vm = ListViewModel()
        vm.networkServise = MockNetworkService()
        vm.model = MockListModel()
        XCTAssertEqual(3, vm.numberOfRows)
    }
    
    func testItemAtIndex() {
        let vm = ListViewModel()
        vm.networkServise = MockNetworkService()
        vm.model = MockListModel()
        XCTAssertEqual("abc", vm.item(at: IndexPath(row: 0, section: 0)))
        XCTAssertEqual("def", vm.item(at: IndexPath(row: 1, section: 0)))
        XCTAssertEqual("gh", vm.item(at: IndexPath(row: 2, section: 0)))
    }
}
