//
//  ImageCVC.swift
//  ImageGallery
//
//  Created by Abhinav Soni on 13/04/25.
//

import UIKit

class ImageCVC: UICollectionViewCell {
    
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var lblCertificate: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var viewSeperatorDot: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
      
          
    }
    func displayMovieData(_ item: Image){
        self.lblMovieName.text = item.title
        self.lblCertificate.text = item.releaseDate
        
        self.lblLanguage.text = item.adult ?? false ? "A" : ""
        self.viewSeperatorDot.isHidden = item.adult ?? false ? false : true
        self.lblGenre.text = ""
        let imgPath = "https://image.tmdb.org/t/p/w500\(item.posterPath ?? "")"
        
        if let url = URL(string: imgPath) {
            // First load
            ImageCache.shared.loadImage(from: url) { [weak self] image in
                print("First load completed")
                self?.imgBanner.image = image
                
                // Load again to test cache
                ImageCache.shared.loadImage(from: url) { image in
                    print("Second load completed")
                }
            }
        } else {
            print("Invalid URL")
        }
        


    }
}
