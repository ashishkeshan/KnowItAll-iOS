//
//  HomePage.swift
//  KnowItAll
//
//  Created by Ashish Keshan on 10/5/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit
import NotificationCenter

class HomePage: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var academicView: UIView!
    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var entertainmentView: UIView!
    @IBOutlet weak var locationsView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    let nc = NotificationCenter.default
    private let refreshControl = UIRefreshControl()
    var topicData = [Topic]()
    var pollData = [Poll]()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        searchBar.delegate = self
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        let clickAcademic = UITapGestureRecognizer(target: self, action:  #selector (self.academicViewTouched (_:)))
        self.academicView.addGestureRecognizer(clickAcademic)
        let clickFood = UITapGestureRecognizer(target: self, action:  #selector (self.foodViewTouched (_:)))
        self.foodView.addGestureRecognizer(clickFood)
        let clickEntertainment = UITapGestureRecognizer(target: self, action:  #selector (self.entertainmentViewTouched (_:)))
        self.entertainmentView.addGestureRecognizer(clickEntertainment)
        let clickLocations = UITapGestureRecognizer(target: self, action:  #selector (self.locationsViewTouched (_:)))
        self.locationsView.addGestureRecognizer(clickLocations)
        refreshControl.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        loadTrending()
    }
    
    @objc private func refreshPage() {
        loadTrending()
        tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        print("VIEW APPEARED")
        searchBar.text = ""
        topicData.removeAll()
        pollData.removeAll()
        loadTrending()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func viewDidDisappear() {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func segmentedControlValueChanged(segment: UISegmentedControl) {
        tableView.reloadData()
    }
    
    func academicViewTouched(_ sender:UITapGestureRecognizer) {
        searchBar.text = "Academic"
        executeSearch()
    }
    
    func foodViewTouched(_ sender:UITapGestureRecognizer) {
        searchBar.text = "Food"
        executeSearch()

    }
    
    func entertainmentViewTouched(_ sender:UITapGestureRecognizer) {
        searchBar.text = "Entertainment"
        executeSearch()

    }
    
    func locationsViewTouched(_ sender:UITapGestureRecognizer) {
        searchBar.text = "Locations"
        executeSearch()

    }
    
    func executeSearch() {
        print("executing search")
        self.tabBarController?.selectedIndex = 1
        nc.post(name:Notification.Name(rawValue:"searchQuery"),
                object: nil,
                userInfo: ["query": searchBar.text!])
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        executeSearch()
        searchBar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(segmentedControl.selectedSegmentIndex == 0) {
            return topicData.count
        } else {
            return pollData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(segmentedControl.selectedSegmentIndex == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopicReviewCell", for: indexPath) as! TopicReviewCell
            cell.postTitle.text = topicData[indexPath.row].title
            cell.numReviews.text = "Reviews: " + String(topicData[indexPath.row].numReviews)
            cell.starRating.rating = topicData[indexPath.row].rating
            switch topicData[indexPath.row].category {
            case 1:
                cell.categoryImage.image = UIImage(named: "Academic")
                break
            case 2:
                cell.categoryImage.image = UIImage(named: "Food")
                break
            case 3:
                cell.categoryImage.image = UIImage(named: "Entertainment")
                break
            case 4:
                cell.categoryImage.image = UIImage(named: "Locations")
                break
            default:
                break
            }
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopicPollCell", for: indexPath) as! TopicPollCell
            cell.pollName.text = pollData[indexPath.row].title
            cell.numVotesLabel.text = String(pollData[indexPath.row].numVotes) + " Votes"
            switch pollData[indexPath.row].category {
            case 1:
                cell.pollCategoryImage.image = UIImage(named: "Academic")
                break
            case 2:
                cell.pollCategoryImage.image = UIImage(named: "Food")
                break
            case 3:
                cell.pollCategoryImage.image = UIImage(named: "Entertainment")
                break
            case 4:
                cell.pollCategoryImage.image = UIImage(named: "Locations")
                break
            default:
                break
            }
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        let cell = tableView.cellForRow(at: indexPath)
        if (cell?.isKind(of: TopicReviewCell.self))! {
            performSegue(withIdentifier: "showReviewPage", sender: self)
        } else {
            performSegue(withIdentifier: "showPollPage", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PollVC {
            let vc = segue.destination as? PollVC
            vc?.poll = self.pollData[self.index]
            vc?.getPollInfo()
        } else if segue.destination is ReviewVC {
            let vc = segue.destination as? ReviewVC
            vc?.topic = self.topicData[self.index]
            vc?.getReviews()
        }
    }
    
    func loadTrending() {
        // Load Topic
        let topicURL = "/getTrending?type=topic"
        var json = getJSONFromURL(topicURL, "GET")
        if json["status"] != 200 { return; }
        for data in json["data"].arrayValue {
            let temp = Topic.init(votes: data["numReviews"].intValue, title: data["title"].stringValue, rating: data["avRating"].doubleValue, cat: data["category"].intValue)
            topicData.append(temp)
        }
        
        // Load Poll
        let pollURL = "/getTrending?type=poll"
        json = getJSONFromURL(pollURL, "GET")
        if json["status"] != 200 { return; }
        for data in json["data"].arrayValue {
            let opts = [String]()
            let distribution = Set<Int>()
            let temp = Poll.init(id: data["id"].intValue, type: 2, time: data["dayLimit"].doubleValue, option: opts, distribution: distribution, votes: data["numVotes"].intValue, text: data["text"].stringValue, cat: data["categoryID"].intValue)
            pollData.append(temp)
        }
        tableView.reloadData()
    }
    
    
}
