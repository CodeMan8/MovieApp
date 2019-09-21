//
//  ViewController.swift
//  MovieApp
//
//  Created by Bartu akman on 10.07.2019.
//  Copyright © 2019 Bartu akman. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
 
    @IBOutlet weak var collectionview: UICollectionView!
    public var isSearching = false

    var  movies = [Movie]()
    var filteredData = [Movie]()
    var session_id_from_login: String?

 
    @IBOutlet weak var searchbar: UISearchBar!
    
 
    override func viewDidLoad() {
        
         super.viewDidLoad()
        
         initdelegate()
        print(session_id_from_login!)
        
        get(completed: {
            print("finished")
            self.collectionview.reloadData()
        }, api: Constans.discoverapi, results: "results")
      
        
        /*
 
       
  
         
         get(completed: {
         print("finished")
         self.collectionview.reloadData()
         }, api: Constans.findapi, results: "movie_results")
       
        
         
         
        
       
        
*/
        
        
    }
    
    
    
    func initdelegate(){
        
        collectionview.delegate = self
        collectionview.dataSource = self
        searchbar.delegate = self
        searchbar.returnKeyType = UIReturnKeyType.done
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailsegue" {
            
            if let dest = segue.destination as? MovieDetailVC{
                
                if let data = sender as? Movie {
                    print(data)
                    let mov =    Movie(name: data.name, directorname: data.directorname, score: data.score, price: data.price, image: data.image, movie_id: data.movie_id)
                    dest.mymovie = mov
                    dest.session_id = session_id_from_login
                    
 
                    
                }
                
            }
        }
        
        
    }
    
    
    
    func get(completed: @escaping Constans.DownloadComplete,api: String,results: String)  {
        
        
       

        
        
        
        Alamofire.request(api).responseJSON { response in
            
            if response.result.isSuccess {
 
                
                let result = response.result
                
                if let responsevalue =  result.value as! [String: Any]? {
 
                    if let yeni = responsevalue[results] as! [Dictionary<String,Any>]?  {
                        
                        for index in 0...yeni.count-1 {
                        if let sonveri = yeni[index] as? Dictionary<String,Any> {
                            
                                    if let title = sonveri["original_title"] as? String, let  score = sonveri["vote_average"] as? Double,
                                         let  price = sonveri["vote_count"] as? Double,
                                         let image  = sonveri["poster_path"] as? String ,
                                         let movie_id = sonveri["id"] as? Int      {
 
                                print(title)
                                print("sontitle")
                                        let movie = Movie(name: title, directorname: "Bartu Akman", score: score, price: price, image: image, movie_id: movie_id)
                                        
                                        
                                        if self.isSearching {
                                            
                                            
                                            self.filteredData.append(movie)
                                             print("iyi gidiyor")
                                        }
                                        else {
                                        
                                        self.movies.append(movie)
                                        }
                                        
                             }
                            
                        }
                            if index == yeni.count-1 {
                                completed()
                               //  self.collectionview.reloadData()
                                print("yenilendi")
                                
                            }
                            
                            
                        }
 
                        
                    }
                   
                }
              
            }
            
        }
        
    }
    


}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate {
    
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
       
     
        
        if searchbar.text  == nil || searchbar.text == "" {
            
            filteredData.removeAll()
            isSearching = false
            view.endEditing(true)
            
            DispatchQueue.main.async {
                
                self.collectionview.reloadData()
            }
        }
        else {
            
            
            
            if searchbar.text!.count >= 3 {
                
                isSearching = true

                
                print(searchbar.text!.count)
                
 
                let  searchapi = "https://api.themoviedb.org/3/search/movie?api_key=\(Constans.access_key)&language=en-US&query=\(searchText)"
                
                 get(completed: {
                    print("finished")
                     self.collectionview.reloadData()
                }, api: searchapi, results: "results")
                
                
            }
            
           
            

            
           // let filteredmovies = self.movies.filter({ $0.name.lowercased()  == searchbar.text?.lowercased()  })
            
            
          //   movies = filteredmovies
            
          
            
           
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            
            return filteredData.count
        }
        else {
            
        return movies.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as? MovieCell {
            
            if isSearching {
                let mycell = filteredData[indexPath.row]
                
                cell.updateUI(movie: mycell)
                return cell
                
            } else {
                
            let mycell = movies[indexPath.row]
            
            cell.updateUI(movie: mycell)
            return cell
                
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mycell = movies[indexPath.row]
        performSegue(withIdentifier: "detailsegue", sender: mycell)
    }
    
    
    
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            
            
            let size = collectionView.frame.size
            let movie_height =  CGFloat(movies.count/3)
            
            return CGSize(width: size.width, height: size.height/3)
       
            
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
}

