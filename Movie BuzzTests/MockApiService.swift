//
//  MockApiService.swift
//  Movie BuzzTests
//
//  Created by Subendran on 22/02/22.
//

import Foundation
@testable import Movie_Buzz

class MockApiService: MoviesAPIServiceProtocol {
    
    func getMoviesList(finalURL: String, completion: @escaping (Bool?, String?, AnyObject?, String?) -> Void) {
        let response = getData(name: "MovieList")
        let decoder = JSONDecoder()
        let values = try! decoder.decode(MovieListModel.self, from: response)
        completion(true,nil,values as AnyObject?,nil)
    }
    
    func getData(name: String, withExtension: String = "json") ->Data {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: name, withExtension: withExtension)
        let data = try! Data(contentsOf: fileUrl!)
        return data
    }
}
