//
//  WatchTableViewCell.swift
//  sMovie
//
//  Created by Sebass on 15/04/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit
import Cosmos

class WatchTableViewCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var watchRank: UILabel!
    @IBOutlet weak var ratingStar: CosmosView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var directorInfoLabel: UILabel!
    
    @IBOutlet weak var directorValueLabel: UILabel!
    @IBOutlet weak var rankImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        settingContainerView()
        settingPoster()
        settingLabelfor(label: title, size: 14,color: UIColor.white)
        settingLabelfor(label: watchRank, size: 12, color: UIColor.white)
        settingLabelfor(label: ratingLabel, size: 14, color: UIColor(hexString: "F09008")!)
        settingLabelfor(label: directorInfoLabel, size: 14, color: UIColor.white)
        settingLabelfor(label: directorValueLabel, size: 14, color: UIColor.white)
        
    }
    
    private func settingLabelfor(label: UILabel, size: CGFloat,color: UIColor){
        label.font = UIFont(name: "Futura", size: size)
        label.font = UIFont.boldSystemFont(ofSize: size)
        label.textColor = color
    }
    
    private func settingPoster(){
        poster.roundCorners(radius: 15)
    }
    private func settingContainerView(){
        containerView.backgroundColor = UIColor(hexString: "404346")
    }

}
