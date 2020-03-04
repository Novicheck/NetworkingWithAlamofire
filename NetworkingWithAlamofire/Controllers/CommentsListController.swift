//
//  CommentsListController.swift
//  NetworkingWithAlamofire
//
//  Created by Denis on 04.03.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

class CommentsListController: UITableViewController {
    
    var comments:[Coment] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = comments[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coment = comments[indexPath.row].fullDiscription
        performSegue(withIdentifier: "ShowDetail", sender: coment)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailCommentsController else {return}
        detailVC.textFullDiscription = sender as? String ?? ""
    }
}
