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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var reviewData = [Review]()
    var pollData = [Poll]()
    var email: String!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(segmentedControl.selectedSegmentIndex == 0) {
            return reviewData.count
        } else {
            return pollData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(segmentedControl.selectedSegmentIndex == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecificReviewCell", for: indexPath) as! SpecificReviewCell
            cell.title.text = "Star Wars"
//                reviews[indexPath.row].topic
            cell.comment.text = reviewData[indexPath.row].comment
            cell.stars.rating = reviewData[indexPath.row].rating
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecificPollCell", for: indexPath) as! SpecificPollCell
            cell.title.text = pollData[indexPath.row].title
            cell.voteNum.text = String(pollData[indexPath.row].numVotes) + " Votes"
            cell.voteChoice.text = "You chose:"
            return cell

        }
    }
    
    func segmentedControlValueChanged(segment: UISegmentedControl) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting up tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        //setting up segmented control
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        //create function to populate reviews and polls
        email = UserDefaults.standard.object(forKey: Login.emailKey) as! String
        loadFromDB()
    }
    
    func loadFromDB() {
//        let urlString = "/myPosts?username="+email
//        let json = getJSONFromURL(urlString, "GET")
//        let topicIDs = json["topicID"]
//        let pollIDs = json["pollID"]
//
//        let reviews = json["reviews"]
//        for review in reviews.arrayValue {
//            let id = review["id"].stringValue
//            let topicID = review["topicID"].stringValue
//            let rating = review["rating"].stringValue
//            let comment = review["comment"].stringValue
//            reviewData.append(Review.init(id:Int(id)!, type:1, rating:Double(rating)!, comment:comment))
//        }
//
//        let polls = json["polls"]
//        for poll in polls.arrayValue {
//            let id = review["id"].stringValue
//            let topicID = review["topicID"].stringValue
//            let rating = review["rating"].stringValue
//            let comment = review["comment"].stringValue
//            let options = [String:String]()
        
            
//            pollData.append(Poll.init(id:Int(id)!, type:2, time:0, option:, distribution:, votes:, text:, cat:)
//        }
//        tableView.reloadData()
    }

}
