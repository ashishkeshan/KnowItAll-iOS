//
//  MyPostsVC.swift
//  KnowItAll
//
//  Created by Ashish Keshan on 10/5/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class MyPostsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(posts[indexPath.row].t==Post.type.Poll) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecificReviewCell", for: indexPath) as! SpecificReviewCell
            cell.stars.rating = 3.5
            cell.title.text = "Star Wars"
            cell.comment.text = "I liked this a lot"
            cell.img.image = UIImage(named:"Entertainment")
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecificPollCell", for: indexPath) as! SpecificPollCell
            cell.title.text = "Star Wars"
            cell.voteNum.text = "30 Votes"
            cell.voteChoice.text = "You voted for \"Good\""
            cell.img.image = UIImage(named:"Entertainment")
            return cell
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SpecificPollCell, forCellReuseIdentifier: "SpecificPollCell")
        let test = User.init(id: 1,email: "a@a.com")
        posts = loadPosts(user: test)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPosts(user:User) -> [Post] {
        var temp = [Post]()
        
        return temp
    }

}
