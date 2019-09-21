//
//  LoginVC.swift
//  MovieApp
//
//  Created by Bartu akman on 12.07.2019.
//  Copyright © 2019 Bartu akman. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {

    @IBOutlet weak var webview: UIWebView!
    
     override func viewDidLoad() {
                 super.viewDidLoad()

     }
    let api = "https://api.themoviedb.org/3/authentication/token/new?api_key=a6f5e40f51a5c31a7d93a112073a1466"
static let REQUEST_TOKEN = "e00c451bc85580b83228b504e84526c83ff598da"
  let token = "https://www.themoviedb.org/authenticate/\(LoginVC.REQUEST_TOKEN)"
    
 
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginsegue" {
            if let dest = segue.destination as? ViewController {
                if  let data = sender as? String {
                    print("string değeri aldık")
                    dest.session_id_from_login = data
 
                }
            }
            
        }
    }
    @IBAction func getSession(_ sender: UIButton) {
        
        
        let parameters: [String: Any] = [
            "request_token" : LoginVC.REQUEST_TOKEN
        ]
        
       
        Alamofire.request("https://api.themoviedb.org/3/authentication/session/new?api_key=a6f5e40f51a5c31a7d93a112073a1466"
, method: .post, parameters: parameters, encoding: JSONEncoding.default , headers: nil)
            .responseJSON { ( response ) in
                if response.result.isSuccess {
                    
                    
                    let result = response.result
                    print(result)
                    if let responsevalue =  result.value as! [String: Any]? {
                        if let session_id = responsevalue["session_id"] as? String {
                            print(session_id)
                               self.performSegue(withIdentifier: "loginsegue", sender: session_id)

                         }
                        
                    }
                }
        }
        
 
        //
 
    }
    
    
    @IBAction func LogButtonClicked(_ sender: UIButton) {
        
        if let url = NSURL(string: token) {
            
            let request = NSURLRequest(url: url as URL)
            webview.loadRequest(request as URLRequest)
        }
 
     }
    

    func get(completed: @escaping Constans.DownloadComplete,query: String)  {
        
        
        
        Alamofire.request(api).responseJSON { response in
            
            if response.result.isSuccess {
                
                
                let result = response.result
                print(result)
                if let responsevalue =  result.value as! [String: Any]? {
                    print(responsevalue)
                }
            }
        }
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
