//
//  MovieDetailVC.swift
//  MovieApp
//
//  Created by Bartu akman on 11.07.2019.
//  Copyright © 2019 Bartu akman. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
class MovieDetailVC: UIViewController {
 
    @IBOutlet weak var titlem: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var score: UILabel!
    
    var session_id : String?
    
      var movie_id : Int!
    
    var mymovie: Movie?{
        didSet{
             updateView()
        }
    }
    func updateView() {
         if let detail = mymovie {
            if let title = titlem, let myprice = price, let mydirector = director, let myimage = image, let myscore = score {
                
                title.text = detail.name
                myprice.text = "\(detail.price)"
                mydirector.text = detail.directorname
                imageLoading(url: detail.image)
                myscore.text = "\(detail.score)"
                 movie_id = detail.movie_id
                print(movie_id!)
             }
        }
    }
    
    
    @IBAction func addWatchListClicked(_ sender: UIButton) {
        
        
         print("clicked")
 
        guard let my_id = session_id else { return }
        
        postWatchList(session: "\(my_id)")
        
          print("evet\(my_id)")
        /*
 
        getWatchList(completed: {
            print("finished")
        }, session: "\(my_id)")
  */

       
        
    }
    
    func getWatchList(completed: @escaping Constans.DownloadComplete,session: String)  {
        
         let newApi =  "https://api.themoviedb.org/3/account/1/watchlist/movies?api_key=\(Constans.access_key)&language=en-US&session_id=\(session)&sort_by=created_at.asc&page=1"
        
        Alamofire.request(newApi).responseJSON { response in
            
            if response.result.isSuccess {
                
                
                let result = response.result
                print(result)
                if let responsevalue =  result.value as! [String: Any]? {
                    print(responsevalue)
                    if let results = responsevalue["results"] as? [Dictionary<String,Any>] {
                        print("başarılı")
                        print(results)
                        if let items = results[0] as? Dictionary<String,Any> {
                            
                            if let title = items["original_title"] as? String {
                                
                                print(title)
                                print("evet")
                                completed()
                            }
                            
                        }
                      
                        
                        
                    }
                }
            }
        }
    }
    
    func  postWatchList(session: String){
        
        let parameters: [String: Any] = [
            "media_type": "movie",
            "media_id": movie_id,
            "watchlist": true
        ]
        print(movie_id)
        print("alaka")
        
        
        Alamofire.request("https://api.themoviedb.org/3/account/1/watchlist?api_key=\(Constans.access_key)&session_id=\(session)"
            , method: .post, parameters: parameters, encoding: JSONEncoding.default , headers: nil)
            .responseJSON { ( response ) in
                if response.result.isSuccess {
                    
                    
                    
                    let result = response.result
                    print(result)
                    print("added")
                }
        }
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
     }
    func imageLoading(url: String) {
        
        let myurl = "https://image.tmdb.org/t/p/original/\(url)"
        image.kf.indicatorType = .activity
        DispatchQueue.main.async {
            self.image.kf.setImage(with: URL(string: myurl), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil, completionHandler: nil)
        }
        print("buradaurl")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
