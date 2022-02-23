//
//  DetailViewModel.swift
//  Movie Buzz
//


import Foundation

class DetailViewModel {
    var movieInfo: MoviesInfo?
    
    init(movieInfo: MoviesInfo){
        self.movieInfo = movieInfo
    }
    
    func getTitle() ->String {
        return movieInfo?.title ?? ""
    }
    
    func getOriginalTitle() ->String {
        return movieInfo?.original_title ?? ""
    }
    
    func getOverView() ->String {
        return movieInfo?.overview ?? ""
    }
    
    func getDate() ->String {
        return movieInfo?.date ?? ""
    }
    
    func getPopularity() ->Double {
        return movieInfo?.popularity ?? 0.0
    }
    
    func getVoteCount() ->String {
        return String(movieInfo?.voteCount ?? 0)
    }
    
    func getWishListedInfo() ->Int {
        return movieInfo?.wishlisted ?? 0
    }
    
    func getPost() ->String {
        return movieInfo?.poster_path ?? ""
    }
    
    func updateValues() {
        if self.movieInfo?.wishlisted == 0 {
            self.movieInfo?.wishlisted = 1
        } else {
            self.movieInfo?.wishlisted = 0
        }
    }
}

