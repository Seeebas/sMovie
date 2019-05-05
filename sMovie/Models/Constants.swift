//
//  Constants.swift
//  sMovie
//
//  Created by Sebass on 18/03/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import Foundation

class Constants{
    
    static let API_KEY = "a86700a4b462a092f5122bef7741001e"
    
    enum lan : String{
        case US = "en-US"
        case PT = "pt-PT"
    }
    
    //the main link to the API website
    static let urlMovie = "https://api.themoviedb.org/3/movie/"
    static let urlSerie = "https://api.themoviedb.org/3/tv/"
    
    static let urlSearch = "https://api.themoviedb.org/3/search/"
    
    //the main link to the API website to get the image
    static let urlMovieImage = "https://image.tmdb.org/t/p/"
    
    
   /* https://api.themoviedb.org/3/search/movie?api_key=a86700a4b462a092f5122bef7741001e&language=en-US&query=B&page=1&include_adult=false
   */
    
    //params that will be added to main link
    static let urlParamDiscovery = "popular"
    static let urlParamUpcoming = "upcoming"
    static let urlParamNowPlaying = "now_playing"
    static let urlParamTopRated = "top_rated"
    //for series
    static let urlParamAirToday = "airing_today"
    static let urlParamOnTheAir = "on_the_air"
    //url for getting series
    static let urlParamLates = "lates"
    // to get the casts from a movie
    static let urlParamCast = "credits"
    static let urlParamSimilar = "similar"
    static let urlParamRecommendation = "recommendations"
    static let urlParamQuery = "query"
    static let urlParamMovie = "movie"
    static let urlParamSerie = "tv"
    // for image size
    static let urlParamImage300w = "w300"
    static let urlParamImage400w = "w400"
    static let urlParamImage500w = "w500"
    
    
    //static link to get the cast from a specific movie
    //static let urlMovieCast = "https://api.themoviedb.org/3/movie/299537/credits"
    
    static let language : String = "language"
    static let api : String = "api_key"
    
    //values for the mapping for the json that ve receive from the request
    static let requestJsonProfilPath = "profile_path"
    static let requestJsonName = "name"
    static let requestJsonId = "id"
    
    static let requestJsonOriginalTitle = "original_title"
    static let requestJsonOriginalName  = "original_name"
    static let requestJsonTitle = "title"
    static let requestJsonPosterPath = "poster_path"
    static let requestJsonBackdrop = "backdrop_path"
    static let requestJsonOverview = "overview"
    static let requestJsonVote = "vote_average"
    static let requestJsonReleaseDate = "release_date"
    static let requestJsonFirstAirDate = "first_air_date"
    static let requestJsonOriginalLanguage = "original_language"
    
    //Mapping values for the extra info for the Movie
    static let requestInfoGenres = "genres"
    static let requestInfoRuntime = "runtime"
    static let requestInfoCast = "cast"
    static let requuestInfoCrew = "crew"
    static let requestInfoResults = "results"
    
    //
    static let totalCell = 8
    

    
    enum categoryMovie : String{
        case discovery = "Discovery"
        case upcoming  = "Upcoming"
        case nowPlaying = "Now Playing"
        case topRated  = "Top Rated"
    }
    
    enum categorySerie : String{
        case airToday = "Air Today"
        case onTheAir  = "On the Air"
        case popular = "Popular"
        case topRated  = "Top Rated"
    }
    
    /** Return API and language = US **/
    static var paramsStandard:[String : String] = [
        Constants.api : Constants.API_KEY,
        Constants.language : Constants.lan.US.rawValue
    ]
    
    static let paramsAPIOnly:[String : String] = [
        Constants.api : Constants.API_KEY
    ]
    
}
