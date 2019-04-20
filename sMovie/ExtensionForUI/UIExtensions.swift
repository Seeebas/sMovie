//
//  UIImageView.swift
//  sMovie
//
//  Created by Sebass on 08/04/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit
import ChameleonFramework

extension UIButton{
    
    func roundCorners(radius: CGFloat){
        self.contentMode = .scaleToFill
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.borderWidth = 0.1
    }
}


extension UIImageView{
    
    
    func roundCornersToBottom(radius:CGFloat){
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = radius
        
        self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        self.clipsToBounds = true
        self.layer.borderWidth = 0.1
        
    }
    
    func roundCorners(radius: CGFloat){
        self.contentMode = .scaleToFill
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.borderWidth = 0.1
    }

}

extension UIView{
    
    func shadowGradianteTopToBottom(frameWidth:CGFloat,frameHeigth:CGFloat){
        self.backgroundColor = UIColor(gradientStyle: UIGradientStyle.topToBottom,
                                       withFrame: CGRect(x: 11, y: 50, width: frameWidth, height: frameHeigth),
                                       andColors: [UIColor.clear,UIColor(hexString: "2B2F32")!])
    }
    
    
    func roundCorner(radius: CGFloat){
        self.contentMode = .scaleToFill
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        self.layer.borderWidth = 0.1
    }

    
}
