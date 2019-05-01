//
//  MovieRequest.swift
//  sMovie
//
//  Created by Sebass on 18/03/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import Alamofire

import SwiftyJSON

class Request{
    
    var jsonRequest:JSON 
    
    var dispatchGroup = DispatchGroup();
    
    init(){
        jsonRequest = JSON.null
    }
    
    
    func fromJSONtoMovies(json : JSON)->[Movie]{
        var listMovie : [Movie] = []
    
        if let movies = json[Constants.requestInfoResults].array {
            for data in movies {
                let movie = Movie()
                movie.id = data[Constants.requestJsonId].stringValue
                movie.title = data[Constants.requestJsonTitle].stringValue
                movie.originalTitle = data[Constants.requestJsonOriginalTitle].stringValue
                movie.posterURL = data[Constants.requestJsonPosterPath].stringValue
                movie.backdropURL = data[Constants.requestJsonBackdrop].stringValue
                movie.overview = data[Constants.requestJsonOverview].stringValue
                movie.vote = returnAtualVoteConvert(value: data[Constants.requestJsonVote].doubleValue)
                movie.releaseDate = data[Constants.requestJsonReleaseDate].stringValue
                movie.language = data[Constants.requestJsonOriginalLanguage].stringValue
                
                listMovie.append(movie)
            }
        }
    
        return listMovie
    }
    
    func fromJSONtoSeries(json : JSON)->[Movie]{
        var listMovie : [Movie] = []
        
        if let movies = json[Constants.requestInfoResults].array {
            for data in movies {
                let movie = Movie()
                movie.id = data[Constants.requestJsonId].stringValue
                movie.title = data[Constants.requestJsonName].stringValue
                movie.originalTitle = data[Constants.requestJsonName].stringValue
                movie.posterURL = data[Constants.requestJsonPosterPath].stringValue
                movie.backdropURL = data[Constants.requestJsonBackdrop].stringValue
                movie.overview = data[Constants.requestJsonOverview].stringValue
                movie.vote = returnAtualVoteConvert(value: data[Constants.requestJsonVote].doubleValue)
                movie.releaseDate = data[Constants.requestJsonFirstAirDate].stringValue
                movie.language = data[Constants.requestJsonOriginalLanguage].stringValue
                movie.isMovie = false
                
                listMovie.append(movie)
            }
        }
        
        return listMovie
    }
    
    
    func fromJSONtoMovieGenders(movie: Movie, json: JSON){
        
        var movieExtraDetail : [MovieExtraDetail] = []
        
        var movieDetails :MovieExtraDetail = MovieExtraDetail()

        if let listExtraInfo = json[Constants.requestInfoGenres].array{
            
            for extra in listExtraInfo{
                movieDetails.id = extra[Constants.requestJsonId].intValue
                movieDetails.genres = extra[Constants.requestJsonName].stringValue
                
                movieExtraDetail.append(movieDetails)
            }
        }
    
        movie.genres = movieExtraDetail
        movie.runtime = json[Constants.requestInfoRuntime].stringValue
        
    
    }
    
    /** Note that info can be "cast" or "crew" **/
    func fromJSONtoCast(json: JSON, info: String)-> [Cast]{
        
        var cast : Cast = Cast()
        var listCast: [Cast] = []
        
        if let listOfCasts = json[info].array{
            
            for data in listOfCasts{
                cast.id = data[Constants.requestJsonId].stringValue
                cast.name = data[Constants.requestJsonName].stringValue
                cast.imageLink = data[Constants.requestJsonProfilPath].stringValue
                
                listCast.append(cast)
            }
        }
        
        return listCast
    
    }
    
    
    private func returnAtualVoteConvert(value: Double)->Double{
        return (value * 5)/10
    }
    
    
    public func GET(url URL : String, parameters params : [String: Any]){
        
        dispatchGroup.enter()
        
        DispatchQueue.main.async {
            Alamofire.request(URL, method: .get, parameters: params, encoding: URLEncoding.default).responseJSON{
                response in
                if (response.result.isSuccess){
                    self.jsonRequest = JSON(response.result.value!)
                }else{
                    print ("ERROR - on request GET Movie \(response.error!)")
                }
                self.dispatchGroup.leave()
            }
        }
        
    }
    
}
