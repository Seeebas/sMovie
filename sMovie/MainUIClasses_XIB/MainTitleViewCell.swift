//
//  MainTitleViewCell.swift
//  sMovie
//
//  Created by Sebass on 09/04/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit

class MainTitleViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func movieTitle(value: String){
        titleLabel.text = value
    }


    func movieTitleSize(of: CGFloat){
        titleLabel.font = UIFont(name: "Futura", size: of)
        titleLabel.font = UIFont.boldSystemFont(ofSize: of)
        
    }
    func movieTitleColor(with: UIColor){
        titleLabel.textColor = with
    }
}
