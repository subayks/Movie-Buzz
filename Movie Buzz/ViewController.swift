//
//  ViewController.swift
//  Movie Buzz
//
//  Created by Subendran on 22/02/22.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController, UIAlertViewDelegate,NVActivityIndicatorViewable, UISearchBarDelegate {
    
    @IBOutlet weak var searchBarTextField: UISearchBar!
    @IBOutlet weak var movieListTableView: UITableView!
    
    var listViewModel = ListViewModel()

    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.listViewModel.makeSourceApiCall()
        
        searchBarTextField.delegate = self
        searchBarTextField.placeholder = "Search Movies Here"
        searchBarTextField.autocorrectionType = .no
        
        self.listViewModel.loadingClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let isLoading = self.listViewModel.isLoading
                if isLoading {
                    let size = CGSize(width: 50, height: 50)
                    self.startAnimating(size, message: "Loading", messageFont: .none, type: .ballScaleRippleMultiple, color: .white, fadeInAnimation: .none)
                    
                } else {
                    self.stopAnimating()
                }
            }
        }
        
        self.listViewModel.showAlert = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let alert = UIAlertController(title: "Service Unavailable", message: "Please Try again later", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        self.listViewModel.setUpDataClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.listViewModel.setUpValues()
            }
        }
        
        self.listViewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.movieListTableView.reloadData()
            }
        }
    }
}

//MARK: Table view Delegates
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listViewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieListTableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
        cell.setValues(cellVM: self.listViewModel.getMovieDetail(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "DetailView") as? DetailView else {
            return
        }
        vc.detailViewModel = self.listViewModel.createDetailViewModel(selectedIndex: indexPath.row)
        vc.movieInfoClosure = { [weak self] (movieinfo) in
            guard let self = self else {return}
            self.listViewModel.updateList(movieInfo: movieinfo)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if maximumOffset - currentOffset <= 10.0 {
            self.listViewModel.loadMoreApiCall()
        }
    }
}

//MARK: Search bar delegates
extension ViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            self.listViewModel.pageNo = 1
            self.listViewModel.searchQuery = ""
        } else {
            self.listViewModel.pageNo = 1
            self.listViewModel.searchQuery = searchText
        }
        self.listViewModel.makeSourceApiCall()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
