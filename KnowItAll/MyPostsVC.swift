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
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PollCell", for: indexPath) as! SpecificPollCell
            cell.postTitle.text = "Star Wars"
            cell.numReviews.text = "30 reviews"
            return cell
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PollCell, forCellReuseIdentifier: "PollCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
