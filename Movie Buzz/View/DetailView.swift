//
//  DetailView.swift
//  Movie Buzz
//
//  Created by Subendran on 22/02/22.
//

import UIKit

class DetailView: UIViewController {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var addToFav: UIButton!
    var movieInfoClosure:((MoviesInfo)->())?
    
    var detailViewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.titlelabel.text = self.detailViewModel?.getTitle()
        self.originalTitle.text = self.detailViewModel?.getOriginalTitle()
        self.DateLabel.text = self.detailViewModel?.getDate()
        self.voteCount.text = self.detailViewModel?.getVoteCount()
        self.overViewLabel.text = self.detailViewModel?.getOverView()
        if self.detailViewModel?.getWishListedInfo() == 1 {
            self.addToFav.setTitle("Remove From Watchlist", for: .normal)
            self.addToFav.layer.borderWidth = 1
            self.addToFav.layer.borderColor = UIColor.red.cgColor
            self.addToFav.backgroundColor = .clear
        } else {
            self.addToFav.setTitle("Add to Watch List", for: .normal)
            self.addToFav.backgroundColor = .red
        }
        
        if let imageURl = self.detailViewModel?.getPost() {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageURl)")!
            
            DispatchQueue.global().async {
                // Fetch Image Data
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        // Create Image and Update Image View
                        self.movieImage.image = UIImage(data: data)
                    }
                }
            }
        }

    }

    @IBAction func actionFavourite(_ sender: Any) {
        self.detailViewModel?.updateValues()
        self.movieInfoClosure?(self.detailViewModel?.movieInfo ?? MoviesInfo())
        self.navigationController?.popViewController(animated: true)
    }
}
