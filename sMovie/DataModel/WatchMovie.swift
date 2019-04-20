//
//  WatchMovie.swift
//  sMovie
//
//  Created by Sebass on 10/04/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import Foundation
import RealmSwift

class WatchMovie: Object{
    @objc dynamic var id: String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var originalTitle : String = ""
    @objc dynamic var overview : String = ""
    @objc dynamic var posterURL : String = ""
    @objc dynamic var backdropURL : String = ""
    @objc dynamic var vote : Double = 0_0
    @objc dynamic var releaseDate : String = ""
    @objc dynamic var runtime : String = ""
    @objc dynamic var language : String = ""
    @objc dynamic var geners : String = ""
    @objc dynamic var directorName : String = ""

    /*
    override static func primaryKey() ->String{
        return "id"
    }
    */
}
