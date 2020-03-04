//
//  DetailCommentsController.swift
//  NetworkingWithAlamofire
//
//  Created by Denis on 04.03.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

class DetailCommentsController: UIViewController {
    
    var textFullDiscription: String!

    @IBOutlet weak var detailTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTextView.text = textFullDiscription
    }
    
    deinit {
        print ("Deinit DetailCommentsController")
    }
}
