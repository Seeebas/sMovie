//
//  MovieViewCell.swift
//  sMovie
//
//  Created by Sebass on 23/03/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit
import Cosmos


/**
    This protocole is used because we are using a collection view embeded in
    a table view. So in order for us to open another page we need this protocols
 **/
protocol GoToPageDetailProtocol {
    /**
        This method recieve a Movie object in order for us to passing info to another page
     **/
    func goToDetail(movie: Movie)
}

class MovieViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imageButton: UIButton!
    
    
    @IBOutlet weak var movieTitleLable: UILabel!
    
    @IBOutlet weak var movieRating: CosmosView!
    
    var movie: Movie = Movie()
    
    var goToPagedetail: GoToPageDetailProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieTitleLable.text = ""
        movieTitleLable.textColor = UIColor.white
        
        imageButton.roundCorners(radius: 15)
        
    }
  
    @IBAction func movieImageClick(_ sender: Any) {
        goToPagedetail?.goToDetail(movie: self.movie)
    }

    
}
