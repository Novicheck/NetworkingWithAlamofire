//
//  Comment.swift
//  NetworkingWithAlamofire
//
//  Created by Denis on 04.03.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation

struct Coment: Decodable {
    let postId: Int?
    let id: Int?
    let name: String?
    let email: String?
    let body: String?
    
    var fullDiscription:String {
        return """
        Post ID: \(postId ?? 0)
        ID: \(id ?? 0)
        Name: \(name ?? "")
        Email: \(email ?? "")
        Body: \(body ?? "")
        """
    }
    
    init (comentDict: [String:Any]) {
        postId = comentDict["postId"] as? Int
        id = comentDict["id"] as? Int
        name = comentDict["name"] as? String
        email =  comentDict["email"] as? String
        body = comentDict["body"] as? String
    }
    
    static func getComments (from jsonData: Any) -> [Coment]? {
        guard let jsonData = jsonData as? Array<[String: Any]> else { return nil }
        return jsonData.compactMap { Coment(comentDict: $0) }
    }
    
    static func getComent (from jsonData: Any) -> Coment? {
        guard let jsonData = jsonData as? [String: Any] else {return nil}
        return Coment(comentDict: jsonData)
    }
}
