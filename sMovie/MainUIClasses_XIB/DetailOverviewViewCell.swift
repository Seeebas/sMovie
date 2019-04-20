//
//  DetailOverviewViewCell.swift
//  sMovie
//
//  Created by Sebass on 06/04/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit

class DetailOverviewViewCell: UITableViewCell {
    
    @IBOutlet weak var yearInfoLabel: UILabel!
    @IBOutlet weak var lengthInfoLabel: UILabel!
    @IBOutlet weak var overviewInfoLabel: UILabel!
    
    @IBOutlet weak var countryInfoLabel: UILabel!
    @IBOutlet weak var storyLineLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addLabelValues(label: yearInfoLabel)
        addLabelValues(label: lengthInfoLabel)
        addLabelValues(label: countryInfoLabel)
        addLabelValues(label: overviewInfoLabel)
        addLabelValues(label: storyLineLabel)
        //Font
        addFont(to: storyLineLabel)
        addFont(to: yearInfoLabel)
        addFont(to: lengthInfoLabel)
        addFont(to: countryInfoLabel)
        overviewInfoLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        // Configure the view for the selected state
    }
    
    private func addLabelValues(label: UILabel){
        label.textColor = UIColor.white
    }
    
    private func addFont(to label: UILabel){
        
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 15)
    }
    
}
