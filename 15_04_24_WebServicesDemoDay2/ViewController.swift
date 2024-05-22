//
//  ViewController.swift
//  15_04_24_WebServicesDemoDay2
//
//  Created by Vishal Jagtap on 22/05/24.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var comments : [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       parseJSON()
    }
    
    func parseJSON(){
        
        url = URL(string: "https://dummyjson.com/comments")
        urlRequest = URLRequest(url: url!)
        urlRequest?.httpMethod = "GET"
        
        urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession?.dataTask(with: urlRequest!, completionHandler: { data, response, error in
            
            let jsonResponse = try! JSONSerialization.jsonObject(with: data!) as! [String : Any]
            
            let comments = jsonResponse["comments"] as! [[String:Any]]
            
            let total = jsonResponse["total"] as! Int
            let skip = jsonResponse["skip"] as! Int
            let limit = jsonResponse["limit"] as! Int
            
            for eachComment in comments{
                let eachCommentId = eachComment["id"] as! Int
                let eachCommentBody = eachComment["body"] as! String
                let eachCommentPostId = eachComment["postId"] as! Int
                
                let eachCommentUser = eachComment["user"] as! [String:Any]
                
                let eachUserId = eachCommentUser["id"] as! Int
                let eachUserUsername = eachCommentUser["username"] as! String
                
                let newUserObject = User(
                                        id: eachUserId,
                                        username: eachUserUsername)
                
                let newCommentObject = Comment(
                                    id: eachCommentId,
                                    body: eachCommentBody,
                                    postId: eachCommentPostId,
                                    user: newUserObject)
                
                self.comments.append(newCommentObject)
            }
            
            print(self.comments)
            
//            DispatchQueue.main.async {
//
//            }
        })
        dataTask?.resume()
    }
}
