//
//  ListViewModelTests.swift
//  Movie BuzzTests
//
//  Created by Subendran on 22/02/22.
//

import XCTest
@testable import Movie_Buzz

class ListViewModelTests: XCTestCase {
    var listViewModel: ListViewModel?
    var mockApiService = MockApiService()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.mockApiService = MockApiService()
        listViewModel = ListViewModel.init(apiService: mockApiService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        if let listViewModel = listViewModel {
            XCTAssertEqual(listViewModel.getNumberOfRows() , 0)
            listViewModel.makeSourceApiCall()
            listViewModel.setUpValues()
           XCTAssertNotNil(listViewModel.pageNo)
           XCTAssertEqual(listViewModel.getNumberOfRows() , 20)
        }
    }
}
