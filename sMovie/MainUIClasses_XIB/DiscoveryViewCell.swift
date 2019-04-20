//
//  DiscoveryViewCell.swift
//  sMovie
//
//  Created by Sebass on 29/03/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit

class DiscoveryViewCell: UICollectionViewCell {

    @IBOutlet weak var discoveryImageButton: UIButton!
    
    var movie: Movie = Movie()
    
    var goToPagedetail: GoToPageDetailProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        discoveryImageButton.roundCorners(radius:15)
    }

    @IBAction func discoveryImageClick(_ sender: Any) {
        goToPagedetail?.goToDetail(movie: self.movie)
    }
}
