//
//  Movie.swift
//  MovieApp
//
//  Created by Bartu akman on 10.07.2019.
//  Copyright © 2019 Bartu akman. All rights reserved.
//

import UIKit

class Movie {
    
    private var _name: String!
    private var _image: String!
    private var _directorname: String!
    private var _score: Double!
    private var _price: Double!
    private var _movie_id : Int!
    
    var name: String {
        
        
            
            return _name
            
        
        
    }
    var movie_id: Int {
        return _movie_id
    }
    var directorname: String {
        
        
            return _directorname
       
    }
    var score: Double {
        
        
            return _score
       
    }
    var price: Double {
        
        
            return  _price
        
    }
    var image: String {
        
       
            
            return _image
            
      
        
    }
    init(name: String, directorname: String, score: Double, price: Double, image: String, movie_id: Int) {
        _name = name
        _directorname = directorname
        _score = score
        _price = price
        _image = image
        _movie_id = movie_id
        
    }
    
    
}
