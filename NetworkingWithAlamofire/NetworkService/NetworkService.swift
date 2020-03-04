//
//  NetworkService.swift
//  NetworkingWithAlamofire
//
//  Created by Denis on 04.03.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation
import Alamofire

class NetworkServise {
    
    static let shared = NetworkServise ()
    
    func fetchDataWithAlamofire(urlString: String, completion: @escaping ([Coment]?) -> Void) {
        request(urlString).validate().responseJSON { dataResponse in
            switch dataResponse.result {
                case .success(let value):
                    let comments = Coment.getComments(from: value) ?? []
                    completion(comments)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func sendDataWithAlamofire(urlString: String, userData: [String:Any], completion: @escaping (Coment?) -> Void) {
        request(urlString, method: .post, parameters: userData).validate().responseJSON { dataResponse in
            switch dataResponse.result {
                case .success(let value):
                    let coment = Coment.getComent(from: value) ?? nil
                completion(coment)
                case .failure(let error):
                    print (error)
            }
        }
    }
}

enum UrlRequest: String, CaseIterable {
    case get = "https://jsonplaceholder.typicode.com/comments"
    case post = "https://jsonplaceholder.typicode.com/posts"
}

