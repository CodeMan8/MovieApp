//
//  Constans.swift
//  MovieApp
//
//  Created by Bartu akman on 11.07.2019.
//  Copyright © 2019 Bartu akman. All rights reserved.
//

import UIKit

class Constans {
    typealias DownloadComplete = () -> ()
   static let access_key = "a6f5e40f51a5c31a7d93a112073a1466"


    static let  searchapi = "https://api.themoviedb.org/3/search/movie?api_key=\(Constans.access_key)&language=en-US&query=you"

  static  let discoverapi = "https://api.themoviedb.org/3/discover/movie?api_key=\(Constans.access_key)&language=en-US&sort_by=popularity.desc"
    static  let findapi = "https://api.themoviedb.org/3/find/tt6146586?api_key=\(Constans.access_key)&language=en-US&external_source=imdb_id"


}
