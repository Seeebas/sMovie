//
//  UtilsLink.swift
//  sMovie
//
//  Created by Sebass on 07/04/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import Foundation


class UtilsLink{
    
    static let utils = UtilsLink()
    
    private init(){}
    
    
    func createLink(mainLink:String, params:String...,separator: String)->String{
        var extraParam = ""
        
        for (index,extraParams) in params.enumerated(){
            if(index == (params.count - 1)){
                extraParam+=extraParams
            }else{
                extraParam+=extraParams + separator
            }
        }
        return (mainLink+extraParam)
    }
    
}
