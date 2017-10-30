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
    private let refreshControl = UIRefreshControl()
    var reviewData = [Review]()
    var pollData = [Poll]()
    var email: String!
    var index = 0
    
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
            cell.title.text = reviewData[indexPath.row].topic
            cell.comment.text = reviewData[indexPath.row].comment
            cell.stars.rating = reviewData[indexPath.row].rating
            //getting topic category
            let topicCheckUrl = "/getPost?type=topic&text="+reviewData[indexPath.row].topic
            let check = getJSONFromURL(topicCheckUrl, "GET")
            let data = check["topic"].arrayValue[0]
            switch data["category"].intValue {
            case 1:
                cell.img.image = UIImage(named: "Academic")
                break
            case 2:
                cell.img.image = UIImage(named: "Food")
                break
            case 3:
                cell.img.image = UIImage(named: "Entertainment")
                break
            case 4:
                cell.img.image = UIImage(named: "Locations")
                break
            default:
                break
            }
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpecificPollCell", for: indexPath) as! SpecificPollCell
            cell.title.text = pollData[indexPath.row].title
            cell.voteNum.text = String(pollData[indexPath.row].numVotes) + " Votes"
            switch pollData[indexPath.row].category {
            case 1:
                cell.img.image = UIImage(named: "Academic")
                break
            case 2:
                cell.img.image = UIImage(named: "Food")
                break
            case 3:
                cell.img.image = UIImage(named: "Entertainment")
                break
            case 4:
                cell.img.image = UIImage(named: "Locations")
                break
            default:
                break
            }
            return cell

        }
    }
    
    func segmentedControlValueChanged(segment: UISegmentedControl) {
        loadFromDB()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting up tableView
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        
        //setting up segmented control
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        //create function to populate reviews and polls
        email = UserDefaults.standard.object(forKey: Login.emailKey) as! String
        loadFromDB()
    }
    
    @objc private func refreshPage() {
        loadFromDB()
        tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func loadFromDB() {
        reviewData.removeAll()
        pollData.removeAll()
        let urlString = "/myPosts?username="+email
        let json = getJSONFromURL(urlString, "GET")
        if json["status"] != 200 { return; }
        let topicIDs = json["topicID"]
        let pcs = json["pc"]

        let reviews = json["reviews"]
        for review in reviews.arrayValue {
            let id = review["id"].stringValue
            let topicID = review["topicID"].stringValue
            let rating = review["rating"].stringValue
            let comment = review["comment"].stringValue
            let topic = topicIDs[topicID].stringValue
            reviewData.append(Review.init(id:Int(id)!, type:1, rating:Double(rating)!, comment:comment, text: topic))
        }

        let polls = json["polls"]
        for poll in polls.arrayValue {
            let id = poll["id"].stringValue
            let text = poll["text"].stringValue
            let numVotes = poll["numVotes"].intValue
            let category = poll["categoryID"].stringValue
            var options = [String]()
            for pc in pcs[id].arrayValue {
                options.append(pc["text"].stringValue)
            }
            let time = poll["dayLimit"].intValue
            
            pollData.append(Poll.init(id:Int(id)!, type:2, time: time, option:options, distribution:Set<Int>(), votes:numVotes, text:text, cat:Int(category)!))
        }
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFromDB()
        tableView.reloadData()
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PollVC {
            let vc = segue.destination as? PollVC
            vc?.poll = self.pollData[self.index]
            vc?.getPollInfo()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        let cell = tableView.cellForRow(at: indexPath)
        if (cell?.isKind(of: SpecificPollCell.self))! {
            performSegue(withIdentifier: "showPollPage", sender: self)
        }
    }

}
