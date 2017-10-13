//
//  MyPostsVC.swift
//  KnowItAll
//
//  Created by Ashish Keshan on 10/5/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit
import Foundation

class MyPostsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //not getting called
        
        print("1")
        if(posts[indexPath.row].t==Post.type.Review) {
            print("2")
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecificReviewCell", for: indexPath) as! SpecificReviewCell
            let curr = posts[indexPath.row] as! Review
            cell.stars.rating = curr.rating!
            cell.title.text = "curr.title!"
            cell.comment.text = "I liked this a lot"
            cell.img.image = UIImage(named:"Entertainment")
            return cell
        }
        else {
            print("3")
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecificPollCell", for: indexPath) as! SpecificPollCell
            let curr = posts[indexPath.row] as! Poll
            cell.title.text = curr.title!
            cell.voteNum.text = curr.title!
            cell.voteChoice.text = "You voted for \"Good\""
            cell.img.image = UIImage(named:"Entertainment")
            return cell
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("before register")
        tableView.register(SpecificPollCell.self, forCellReuseIdentifier: "SpecificPollCell")
        print("after register")
        
        //testing with json
//        let test = User.init(id: 1,email: "a@a.com")
//        posts = loadPosts(user: test)
        //testing without json
        posts.append(Poll.init(id: 1, type: 2, votes: 30, text: "Hello!"))
        posts.append(Poll.init(id: 1, type: 2, votes: 60, text: "BYE!"))
        posts.append(Review.init(id: 1, type: 1, rating: 3.7, comment: "So-so"))
        posts.append(Review.init(id: 1, type: 1, rating: 5, comment: "Great"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPosts(user:User) -> [Post] {
        var temp = [Post]()
        let URL_STRING = "https://3b1b6e95.ngrok.io/api/myPosts?username=a@a.com"
        
        let url = NSURL(string: URL_STRING)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                print(jsonObj)

                if let reviewArray = jsonObj!.value(forKey: "reviews") as? NSArray {
                    for i in reviewArray{
                        if let reviewDict = i as? NSDictionary {
                            let rating = reviewDict.value(forKey: "rating")
                            let id = reviewDict.value(forKey: "id")
                            let comment = reviewDict.value(forKey: "comment")
                            
//                            let date = reviewDict.value(forKey: "dateCreated")
                            let type = 1
                            
                            let review = Review.init(id: id as! Int, type: type, rating: rating as! Double, comment: comment as! String as! String/*, text: text*/)
                            self.posts.append(review)
                        }
                    }
                }
                
                if let pollArray = jsonObj!.value(forKey: "poll") as? NSArray {
                    for i in pollArray{
                        if let pollDict = i as? NSDictionary {
                            let text = pollArray.value(forKey: "text")
                            let id = pollArray.value(forKey: "id")
                            let numVotes = pollDict.value(forKey: "numVotes")
//                            let openForever = pollDict.value(forKey: "openForever")
//                            let date = reviewDict.value(forKey: "dateCreated")
                            let type = 2
                            
                            let poll = Poll.init(id: id as! Int, type: type, votes: numVotes as! Int,text: text as! String)
                            self.posts.append(poll)
                        }
                    }
                }
                
            }
        }).resume()
        
        return temp
    }

}
