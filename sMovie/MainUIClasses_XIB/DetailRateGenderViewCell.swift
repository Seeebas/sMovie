//
//  DetailRateGenderViewCell.swift
//  sMovie
//
//  Created by Sebass on 05/04/2019.
//  Copyright © 2019 Sebass. All rights reserved.
//

import UIKit
import Cosmos
import RealmSwift

class DetailRateGenderViewCell: UITableViewCell {
    
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var ratingStars: CosmosView!
    
    @IBOutlet weak var heartImage: UIImageView!
    
    var watchMovie : WatchMovie = WatchMovie()
    
    var movie: Movie = Movie() {
        didSet{
            watchMovie = populateMovieToWatchMovie(movie: self.movie)
        }
    }
    
    var realm = try! Realm()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTaped(imageTapGesture:)))
       
        heartImage.isUserInteractionEnabled = true
        heartImage.addGestureRecognizer(imageTapGesture)
        
        genderLabel.textColor = UIColor.white
    
    }
    
    
    @objc func imageTaped(imageTapGesture: UITapGestureRecognizer){
        
        if (watchMovie.isInvalidated){
            watchMovie = populateMovieToWatchMovie(movie: self.movie)
        }
        
        if heartImage.image == UIImage(named: "HeartClick"){
            heartImage.image = UIImage(named: "HeartUnclick")
            //here we want do delete data
            do{
                try realm.write {
                    print("Movie ID \(watchMovie.id) was sucessfuly deleted from Realm object")
                    realm.delete(watchMovie)                
                }
                
            }catch{
               print("Error deleting movie with id \(watchMovie.id) to Realm \(error)")
            }
      
        }else{
            heartImage.image = UIImage(named: "HeartClick")
            //here we now want to save data
            do{
                try realm.write {
                    print("Movie ID \(watchMovie.id) was sucessfuly saved to Realm object")
                    realm.add(watchMovie)
                }
                
            }catch{
                print("Error saving movie with id \(watchMovie.id) to Realm \(error)")
            }
        }
    }
    
    private func populateMovieToWatchMovie(movie: Movie)->WatchMovie{
        
        var newWatch = WatchMovie()
        
        if(!movieInWatchList()){
            heartImage.image = UIImage(named: "HeartUnclick")
        }else{
            heartImage.image = UIImage(named: "HeartClick")
        }
        
        let predicat = NSPredicate(format: "id CONTAINS[cd] %@", movie.id)
        
        if (!realm.objects(WatchMovie.self).filter(predicat).isEmpty){
           newWatch = realm.objects(WatchMovie.self).filter(predicat).first!
        }else{
            newWatch.id = movie.id
            newWatch.title = movie.title
            newWatch.originalTitle = movie.originalTitle
            newWatch.overview = movie.overview
            newWatch.posterURL = movie.posterURL
            newWatch.backdropURL = movie.backdropURL
            newWatch.vote = movie.vote
            newWatch.releaseDate = movie.releaseDate
            newWatch.runtime = movie.runtime
            newWatch.language = movie.language
            newWatch.geners = genderLabel.text!
            newWatch.directorName = movie.directorName
            newWatch.isMovie = movie.isMovie
        }
    
        return newWatch
    }
    
    private func movieInWatchList()-> Bool{
        let listOfWatchList: Results<WatchMovie>?
        
        let predicat = NSPredicate(format: "id = %@", movie.id)
       
        listOfWatchList = realm.objects(WatchMovie.self).filter(predicat)
        
        return (!listOfWatchList!.isEmpty) ? true : false

    }
    
}
