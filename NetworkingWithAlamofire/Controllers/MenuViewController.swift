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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userRequests.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CommentViewCell
        let text = userRequests[indexPath.item].rawValue
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
                commentsListVC.fetchData()
            case "AlamofirePost":
                commentsListVC.setData()
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
