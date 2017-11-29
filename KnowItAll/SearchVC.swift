//
//  SearchVC.swift
//  KnowItAll
//
//  Created by Ashish Keshan on 10/5/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var noResultsView: UIView!
    @IBOutlet weak var trendingButton1: UIButton!
    @IBOutlet weak var trendingButton2: UIButton!
    @IBOutlet weak var trendingButton3: UIButton!
    @IBOutlet weak var trendingButton4: UIButton!
    @IBOutlet weak var dropDown: UITableView!
    
    var topics = [Topic]()
    var polls = [Poll]()
    var index = 0
    private let refreshControl = UIRefreshControl()
    var tags = [String]()
    var tagOptions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        dropDown.delegate = self
        dropDown.dataSource = self
        searchBar.delegate = self
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        tableView.backgroundView = noResultsView // Set no results to background view
        search(param: "") // Load all polls/reviews initially
        
        let nc = NotificationCenter.default // Note that default is now a property, not a method call
        nc.addObserver(forName:Notification.Name(rawValue:"searchQuery"),
                       object:nil, queue:nil,
                       using:catchNotification)
        refreshControl.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        // Do any additional setup after loading the view.
        
        loadTrendingTags()
        buttonSetup()
        tagOptions = dropDownSetUp()
    }
    
    @objc private func refreshPage() {
        search(param: searchBar.text!)
        tableView.reloadData()
        tagOptions = dropDownSetUp()
        dropDown.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        search(param: searchBar.text!)
        tableView.reloadData()
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    /*
     * NOTIFICATION FUNCTIONS
     */
    func catchNotification(notification:Notification) -> Void {
        let userInfo = notification.userInfo
        let query = userInfo?["query"] as? String
        searchBar.text = query
        search(param: query!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     * TABLE DELEGATE/DATASOURCE FUNCTIONS
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            if polls.count + topics.count == 0 {
                tableView.backgroundView?.isHidden = false
            } else {
                tableView.backgroundView?.isHidden = true
            }
            return polls.count + topics.count
        }
        else {
            let options:[String] = dropDownSetUp()
            return options.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //determining which cell to use (poll vs topic)
        if tableView == self.tableView {
            if indexPath.row < (topics.count) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TopicReviewCell", for: indexPath) as! TopicReviewCell
                cell.starRating.rating = topics[indexPath.row].rating
                cell.postTitle.text = topics[indexPath.row].title
                cell.numReviews.text = "Reviews: " + String(topics[indexPath.row].numReviews)
                switch topics[indexPath.row].category {
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
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TopicPollCell", for: indexPath) as! TopicPollCell
                cell.pollName.text = polls[indexPath.row-topics.count].title
                cell.numVotesLabel.text = "Votes: " + String(polls[indexPath.row-topics.count].numVotes)
                switch polls[indexPath.row-topics.count].category {
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
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tagCell
            cell.option.text = tagOptions[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            self.index = indexPath.row
            let cell = tableView.cellForRow(at: indexPath)
            if (cell?.isKind(of: TopicReviewCell.self))! {
                performSegue(withIdentifier: "showReviewPage", sender: self)
            } else {
                performSegue(withIdentifier: "showPollPage", sender: self)
            }
        }
        else {
            let cell = tableView.cellForRow(at: indexPath) as! tagCell
            searchBar.text = cell.option.text
            dropDown.isHidden = true
            search(param: searchBar.text!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PollVC {
            let vc = segue.destination as? PollVC
            vc?.poll = self.polls[self.index - topics.count]
            vc?.getPollInfo()
        } else if segue.destination is ReviewVC {
            let vc = segue.destination as? ReviewVC
            vc?.topic = self.topics[self.index]
            vc?.getReviews()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /*
     * SEARCHBAR DELEGATE FUNCTIONS
     */
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dropDown.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dropDown.isHidden = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //function used to send search queries whenever the text in searchbar has been edited
        //can probably be optimized a bit to improve search speed
        search(param: searchBar.text!)
        tagOptions = dropDownSetUp()
        dropDown.reloadData()
        if searchBar.text != "" {
            dropDown.isHidden = false
        }
        else {
            dropDown.isHidden = true
        }
    }
    
    func search(param:String) {
        //http://127.0.0.1:8000/api/search?query=Academic
        topics.removeAll()
        polls.removeAll()
        
        var urlString = ""
        urlString = (searchBar.text! == "") ? "/getTrending?type=all": "/search?query=" + searchBar.text!
        
        
        let json = getJSONFromURL(urlString, "GET")
//        print(json)
        let status = json["status"]
        
        // Check if status is good
        if status == 200 {
            for r in json["data"].arrayValue {
                
                //returns null if its poll
                //polls dont have this attribute
                if(r["numReviews"] == JSON.null) {
                    let opts = [String]()
                    let distribution = Set<Int>()
                    let temp = Poll.init(id: r["id"].intValue, type: 2, time: r["dayLimit"].intValue, option: opts, distribution: distribution, votes: r["numVotes"].intValue, text: r["text"].stringValue, cat: r["categoryID"].intValue)
                    polls.append(temp)
                }
                else {
                    let temp = Topic.init(votes: r["numReviews"].intValue, title: r["title"].stringValue, rating: r["avRating"].doubleValue, cat: r["category"].intValue)
                    topics.append(temp)
                }
            }
        } // endif
        else {
            let alert = UIAlertController(title: "Error!", message: "Error, failed to search", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        self.tableView.reloadData()
    }
    
    func loadTrendingTags() {
        let trendingTag = "/getTrending?type=tags&number=4"
        var json = getJSONFromURL(trendingTag, "GET")
        if json["status"] != 200 { return; }
        for data in json["data"].arrayValue {
            tags.append(data["title"].stringValue)
        }
        
        trendingButton1.setTitle(tags[0], for: .normal)
        trendingButton2.setTitle(tags[1], for: .normal)
        trendingButton3.setTitle(tags[2], for: .normal)
        trendingButton4.setTitle(tags[3], for: .normal)
        
        trendingButton1.setTitleColor(UIColor.red, for: .selected)
        trendingButton2.setTitleColor(UIColor.red, for: .selected)
        trendingButton3.setTitleColor(UIColor.red, for: .selected)
        trendingButton4.setTitleColor(UIColor.red, for: .selected)
    }
    
    @IBAction func tagButtonPressed(_ sender: UIButton) {
        if(sender.title(for: .normal) == tags[0]) {
            searchBar.text = tags[0]
            search(param: tags[0])
        }
        else if(sender.title(for: .normal) == tags[1]) {
            searchBar.text = tags[1]
            search(param: tags[1])
        }
        else if(sender.title(for: .normal) == tags[2]) {
            searchBar.text = tags[2]
            search(param: tags[2])
        }
        else if(sender.title(for: .normal) == tags[3]) {
            searchBar.text = tags[3]
            search(param: tags[3])
        }
    }
    
    func buttonSetup() {
        trendingButton1.layer.cornerRadius = 15
        trendingButton1.layer.borderWidth = 1
        trendingButton1.layer.borderColor = UIColor.white.cgColor
        
        trendingButton2.layer.cornerRadius = 15
        trendingButton2.layer.borderWidth = 1
        trendingButton2.layer.borderColor = UIColor.white.cgColor
        
        trendingButton3.layer.cornerRadius = 15
        trendingButton3.layer.borderWidth = 1
        trendingButton3.layer.borderColor = UIColor.white.cgColor
        
        trendingButton4.layer.cornerRadius = 15
        trendingButton4.layer.borderWidth = 1
        trendingButton4.layer.borderColor = UIColor.white.cgColor
    }
    
    func dropDownSetUp() -> [String] {
        let trendingTag = "/getTags?startsWith=" + searchBar.text!
        var json = getJSONFromURL(trendingTag, "GET")
        
        var options = [String]()
        if json["status"] != 200 {
            options.append("Error, status != 200")
            return options
        }
        
        let temp = json["tags"].stringValue
        let temparray = temp.split(separator: ",")
        
        for x in temparray {
            options.append(String(x))
        }
        
        return options
    }
}
