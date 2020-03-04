//
//  CommentViewController.swift
//  NetworkingWithAlamofire
//
//  Created by Denis on 04.03.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

class MenuViewController: UICollectionViewController {
    
    private let userRequests = UserRequest.allCases
    private let userData = [
      "postId": 1,
      "id": 1,
      "name": "id labore ex et quam laborum",
      "email": "Eliseo@gardner.biz",
      "body": "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium"
        ] as [String : Any]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userRequests.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CommentViewCell else {return UICollectionViewCell()}
        let text = userRequests[indexPath.row].rawValue
        cell.menuLabel.text = text
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userRequest = userRequests[indexPath.item]
        
        switch userRequest {
            case .alamofireGet:
                performSegue(withIdentifier: "AlamofireGet", sender: nil)
            case .alamofirePost:
                performSegue(withIdentifier: "AlamofirePost", sender: nil)
        }
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let commentsListVC = segue.destination as? CommentsListController else { return }
        guard let segueIdentifire = segue.identifier else { return }
        switch segueIdentifire {
            case "AlamofireGet":
                NetworkServise.shared.fetchDataWithAlamofire(urlString: UrlRequest.get.rawValue) { coments in
                    DispatchQueue.main.async {
                        commentsListVC.comments = coments ?? []
                        commentsListVC.tableView.reloadData()
                    }
            }
            case "AlamofirePost":
                NetworkServise.shared.sendDataWithAlamofire(urlString: UrlRequest.post.rawValue, userData: userData) { coment in
                    DispatchQueue.main.async {
                        guard let coment = coment else {return}
                        commentsListVC.comments.append(coment)
                        commentsListVC.tableView.reloadData()
                    }
            }
            default: break
        }
    }
}


extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 16, bottom: 0, right: 16)
    }
}

enum UserRequest: String, CaseIterable {
    case alamofireGet = "Alamofire GET"
    case alamofirePost = "Alamofire POST"
}
