//
//  DetailViewModelTests.swift
//  Movie BuzzTests
//
//  Created by Subendran on 22/02/22.
//

import XCTest
@testable import Movie_Buzz

class DetailViewModelTests: XCTestCase {
    var detailViewModel: DetailViewModel?
    var mockApiService = MockApiService()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.mockApiService = MockApiService()
        detailViewModel = DetailViewModel.init(movieInfo: MoviesInfo(title: "Through My Window", original_title: "A través de mi ventana", overview: "Raquel's longtime crush on her next-door neighbor turns into something more when he starts developing feelings for her, despite his family's objections.", date: "2022-02-04", popularity: 1228.889, voteCount: 1164, wishlisted: 1, poster_path: "/4rsomWxlqnHt3muGYK06auhOib6.jpg"))
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        if let viewModel = self.detailViewModel {
            XCTAssertEqual(viewModel.getTitle(), "Through My Window")
            XCTAssertEqual(viewModel.getOriginalTitle(), "A través de mi ventana")
            XCTAssertEqual(viewModel.getOverView(), "Raquel's longtime crush on her next-door neighbor turns into something more when he starts developing feelings for her, despite his family's objections.")
            XCTAssertEqual(viewModel.getDate(), "2022-02-04")
            XCTAssertEqual(viewModel.getPopularity(), 1228.889)
            XCTAssertEqual(viewModel.getPost(), "/4rsomWxlqnHt3muGYK06auhOib6.jpg")
            XCTAssertEqual(viewModel.getVoteCount(), String(1164))
            XCTAssertEqual(viewModel.getWishListedInfo(), 1)
            viewModel.updateValues()
            XCTAssertEqual(viewModel.getWishListedInfo(), 0)
        }
    }
}
