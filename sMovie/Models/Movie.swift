//
//  Movie.swift
//  sMovie
//
//  Created by Sebass on 18/03/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import Foundation


class Movie{
    
    var id : String
    var title : String
    var originalTitle : String
    var overview : String
    var posterURL : String
    var backdropURL : String
    var vote : Double
    var releaseDate : String
    var runtime : String
    var language : String
    var genres : [MovieExtraDetail]
    var directorName : String
    var isMovie: Bool
    
    
    init(){
        self.id = ""
        self.title = ""
        self.originalTitle = ""
        self.overview = ""
        self.posterURL = ""
        self.backdropURL = ""
        self.vote = 0_0
        self.releaseDate = ""
        self.runtime = ""
        self.language = ""
        self.genres = []
        self.directorName = ""
        self.isMovie = true
    }
    
}

struct MovieExtraDetail{
    var id: Int = 0
    var genres : String = ""
    var runtime : String  = ""
    var language : String =  ""
}
