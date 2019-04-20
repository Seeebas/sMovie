//
//  CastViewCell.swift
//  sMovie
//
//  Created by Sebass on 08/04/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit
import ChameleonFramework

class CastViewCell: UICollectionViewCell {
    
    @IBOutlet weak var castImage: UIButton!
    @IBOutlet weak var imageShadowView: UIView!
    @IBOutlet weak var castNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        castImage.roundCorners(radius: 15)
        
        imageShadowView.shadowGradianteTopToBottom(frameWidth: 90, frameHeigth: 60)
    }
}
