//
//  MovieCell.swift
//  MovieApp
//
//  Created by Bartu akman on 10.07.2019.
//  Copyright © 2019 Bartu akman. All rights reserved.
//

import UIKit
import Kingfisher
 class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieprice: UILabel!
    @IBOutlet weak var moviescore: UILabel!
    @IBOutlet weak var moviedirector: UILabel!
    @IBOutlet weak var moviename: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     }
    
    func updateUI(movie: Movie){
        
        movieprice.text = "$ \(movie.price)"
        moviescore.text = "\(movie.score)"
        moviedirector.text = movie.directorname
        moviename.text = movie.name
        imageLoading(url: movie.image)
    }
    func imageLoading(url: String) {
        
 
         let myurl = "https://image.tmdb.org/t/p/original/\(url)"
        imageview.kf.indicatorType = .activity
        DispatchQueue.main.async {
            self.imageview.kf.setImage(with: URL(string: myurl), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil, completionHandler: nil)
        }
        print("buradaurl")
    }
    
    
}
