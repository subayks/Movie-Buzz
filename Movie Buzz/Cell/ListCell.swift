//
//  ListCell.swift
//  Movie Buzz
//
//  Created by Subendran on 22/02/22.
//

import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var overViewLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet var wishListImage: UIImageView!
    
    
    @IBOutlet weak var heartFill: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setValues(cellVM: ListCellViewModel) {
        self.movieName.text = cellVM.getTitle()
        self.overViewLabel.text = cellVM.getOverView()
        self.dateLabel.text = cellVM.getDate()
        if cellVM.getWishListedInfo() == 1 {
            self.wishListImage.isHidden = true
            self.heartFill.isHidden = false
        } else {
            self.wishListImage.isHidden = false
            self.heartFill.isHidden = true
        }
        if let imageURl = cellVM.getPosterpath() {
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
    
}
