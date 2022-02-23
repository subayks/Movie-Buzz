//
//  ListCellViewModel.swift
//  Movie Buzz
//
//  Created by Subendran on 22/02/22.
//

import Foundation
class ListCellViewModel {
    var moviesInfo: MoviesInfo?
    
    init(moviesInfo: MoviesInfo) {
        self.moviesInfo = moviesInfo
    }
    
    func getTitle() ->String {
        return moviesInfo?.title ?? ""
    }
    
    func getOverView() ->String {
        return moviesInfo?.overview ?? ""
    }
    
    func getDate() ->String {
        return moviesInfo?.date ?? ""
    }
    
    func getPopularity() ->Double {
        return moviesInfo?.popularity ?? 0.0
    }
    
    func getWishListedInfo() ->Int {
        return moviesInfo?.wishlisted ?? 0
    }
    
    func getPosterpath() ->String? {
        return moviesInfo?.poster_path
    }
}
