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
    
    var reviews = [Review]()
    var polls = [Poll]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(segmentedControl.selectedSegmentIndex == 0) {
            return reviews.count
        } else {
            return polls.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(segmentedControl.selectedSegmentIndex == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecificReviewCell", for: indexPath) as! SpecificReviewCell
            cell.title.text = "Star Wars"
//                reviews[indexPath.row].topic
            cell.comment.text = reviews[indexPath.row].comment
            cell.stars.rating = reviews[indexPath.row].rating
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecificPollCell", for: indexPath) as! SpecificPollCell
            cell.title.text = polls[indexPath.row].title
            cell.voteNum.text = String(polls[indexPath.row].numVotes) + " Votes"
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

        //testing without json
        polls.append(Poll.init(id: 1, type: 2, votes: 30, text: "Hello!"))
        polls.append(Poll.init(id: 1, type: 2, votes: 60, text: "BYE!"))
        reviews.append(Review.init(id: 1, type: 1, rating: 3.7, comment: "So-so"))
        reviews.append(Review.init(id: 1, type: 1, rating: 5, comment: "Great"))
        
        //create function to populate reviews and polls
    }

}
