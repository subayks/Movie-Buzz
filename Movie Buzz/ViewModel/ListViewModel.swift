//
//  ListViewModel.swift
//  Movie Buzz
//
//  Created by Subendran on 22/02/22.
//

import Foundation

struct MoviesInfo {
    var title: String?
    var original_title: String?
    var overview: String?
    var date: String?
    var popularity: Double?
    var voteCount: Int?
    var wishlisted: Int?
    var poster_path: String?
}

class ListViewModel {
    
    var apiService: MoviesAPIServiceProtocol
    var model: MovieListModel?
    var movieList: [MoviesInfo]?
    
    var loadingClosure:(()->())?
    var isLoading: Bool = false {
        didSet {
            self.loadingClosure?()
        }
    }
    var showAlert:(() -> ())?
    var setUpDataClosure:(() ->())?
    var reloadTableView:(()->())?
    
    var pageNo: Int = 01
    var selectedIndex: Int?
    var searchQuery: String = ""
    
    init(apiService:MoviesAPIServiceProtocol = ApiServices()) {
        self.apiService = apiService
    }
    
    func loadMoreApiCall() {
        if (self.model?.total_pages ?? 0) > pageNo {
            pageNo = pageNo + 1
            makeSourceApiCall()
        }
    }
    
    //MARK:- Api call for list
    func makeSourceApiCall() {
        let finalURL = "https://api.themoviedb.org/3/search/movie?api_key=2ad017f21b57c6def2d28266f40dc5c9&query=\(searchQuery)%20&page=\(self.pageNo)"
        
        if Reachability.isConnectedToNetwork() {
            self.isLoading = true
            
            apiService.getMoviesList(finalURL: finalURL, completion: { (status: Bool? , errorCode: String?,result: AnyObject?, errorMessage: String?) -> Void in
                if status == true {
                    self.model = result as? MovieListModel
                    self.isLoading = false
                    self.setUpDataClosure?()
                } else {
                    self.showAlert?()
                    
                }
            })
        }
    }
    
    func getMovieDetail(index: Int) ->ListCellViewModel {
        return ListCellViewModel(moviesInfo: self.movieList?[index] ?? MoviesInfo())
    }
    
    func getNumberOfRows() ->Int {
        return self.movieList?.count ?? 0
    }
    
    func setUpValues() {
        if let results = self.model?.results {
            var moviesArray = [MoviesInfo]()
            for item in results {
                var movieInfo = MoviesInfo()
                movieInfo.title = item.title
                movieInfo.original_title = item.original_title
                movieInfo.overview = item.overview
                movieInfo.date = item.release_date
                movieInfo.popularity = item.popularity
                movieInfo.voteCount = item.vote_count
                movieInfo.wishlisted = 0
                movieInfo.poster_path = item.poster_path
                moviesArray.append(movieInfo)
            }
            if self.pageNo == 1 {
                self.movieList = moviesArray
            } else {
                self.movieList?.append(contentsOf: moviesArray)
            }
        }
        self.reloadTableView?()
    }
    
    func createDetailViewModel(selectedIndex: Int) ->DetailViewModel {
        self.selectedIndex = selectedIndex
        return DetailViewModel(movieInfo: self.movieList?[selectedIndex] ?? MoviesInfo())
    }
    
    func updateList(movieInfo: MoviesInfo) {
        if let selectedIndex = self.selectedIndex {
            self.movieList?.remove(at: selectedIndex)
            self.movieList?.insert(movieInfo, at: selectedIndex)
        }
        self.reloadTableView?()
    }
}
