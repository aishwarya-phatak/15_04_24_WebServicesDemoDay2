//
//  APIResponse.swift
//  15_04_24_WebServicesDemoDay2
//
//  Created by Vishal Jagtap on 22/05/24.
//

import Foundation
struct APIResponse{
    var comments : [Comment]
    var total : Int
    var skip : Int
    var limit : Int
}

struct Comment{
    var id : Int
    var body : String
    var postId : Int
    var user : User
}

struct User{
    var id : Int
    var username : String
}
