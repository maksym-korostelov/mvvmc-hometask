//
//  ListViewModel.swift
//  homeTask1_MVVMC_v2Tests
//
//  Created by Maksym Korostelov on 12/8/19.
//  Copyright © 2019 Maksym Korostelov. All rights reserved.
//

@testable import homeTask1_MVVMC_v2
import XCTest

class ListViewModelTests: XCTestCase {
    var testViewModel: ListViewModelProtocol!

    override func setUp() {
        super.setUp()

        let model = MockListModel()
        let networkServise = MockNetworkService()
        let coordinator = MockListCoordinator()

        testViewModel = ListViewModel(
            model: model,
            networkServise: networkServise,
            coordinator: coordinator
        )
    }

    override func tearDown() {
        super.tearDown()

        testViewModel = nil
    }

    private final class MockNetworkService: NetworkService {
        override func requestData(url _: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
            let str = "abc\ndef\ngh\n"
            guard let data = str.data(using: .utf8) else {
                completionHandler(.failure(NSError()))
                return
            }
            completionHandler(.success(data))
        }
    }

    private final class MockListModel: ListModelProtocol {
        var viewModel: ListViewModelProtocol?
        var randomList: [String] = []
    }

    private final class MockListCoordinator: ListCoordinatorProtocol {
        weak var delegate: LoginCoordinatorDelegate?

        func start() {}
    }

    func testInitialDefaults() {
        XCTAssertNil(testViewModel.view)
    }

    func testDataLoadedAndParsed() {
        let expectedResult = ["abc", "def", "gh"]
        XCTAssertEqual(expectedResult, testViewModel.randomList)
    }

    func testNumberOfRows() {
        XCTAssertEqual(3, testViewModel.numberOfRows)
    }

    func testItemAtIndex() {
        XCTAssertEqual("abc", testViewModel.item(at: IndexPath(row: 0, section: 0)))
        XCTAssertEqual("def", testViewModel.item(at: IndexPath(row: 1, section: 0)))
        XCTAssertEqual("gh", testViewModel.item(at: IndexPath(row: 2, section: 0)))
    }
}
