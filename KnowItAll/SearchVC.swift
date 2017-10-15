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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var topics = [Topic]()
    var polls = [Poll]()
    var searchActive:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        let nc = NotificationCenter.default // Note that default is now a property, not a method call
        nc.addObserver(forName:Notification.Name(rawValue:"MyNotification"),
                       object:nil, queue:nil,
                       using:catchNotification)
        // Do any additional setup after loading the view.
    }
    
    func catchNotification(notification:Notification) -> Void {
        print("Catch notification")
        let userInfo = notification.userInfo
        let query = userInfo?["query"] as? String
        searchBar.text = query
        search(param: query!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return polls.count + topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < (topics.count) {
            print("review:" + String(indexPath.row))
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopicReviewCell", for: indexPath) as! TopicReviewCell
            cell.starRating.rating = topics[indexPath.row].rating
            cell.postTitle.text = topics[indexPath.row].title
            cell.numReviews.text = "Reviews: " + String(topics[indexPath.row].numReviews)
            switch topics[indexPath.row].category {
            case 1:
                let img = UIImage(named: "Academic")
                cell.categoryImage = UIImageView(image: img)
                break
            case 2:
                let img = UIImage(named: "Food")
                cell.categoryImage = UIImageView(image: img)
                break
            case 3:
                let img = UIImage(named: "Entertainment")
                cell.categoryImage = UIImageView(image: img)
                break
            case 4:
                let img = UIImage(named: "Location")
                cell.categoryImage = UIImageView(image: img)
                break
            default:
                break
            }
            return cell
        } else {
            print("poll:" + String(indexPath.row))
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopicPollCell", for: indexPath) as! TopicPollCell
            cell.pollName.text = polls[indexPath.row-topics.count].title
            cell.numVotesLabel.text = "Votes: " + String(polls[indexPath.row-topics.count].numVotes)
            switch polls[indexPath.row-topics.count].category {
            case 1:
                cell.pollCategoryImage.image = UIImage(named: "Academics")
                break
            case 2:
                cell.pollCategoryImage.image = UIImage(named: "Food")
                break
            case 3:
                cell.pollCategoryImage.image = UIImage(named: "Entertainment")
                break
            case 4:
                cell.pollCategoryImage.image = UIImage(named: "Location")
                break
            default:
                break
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
//        TODO
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //SEARCHBAR
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        search(param: searchBar.text!)
        if(topics.count + polls.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
    }
    
    func search(param:String) {
        //http://127.0.0.1:8000/api/search?query=Academic
        topics.removeAll()
        polls.removeAll()
        
        let urlString = "/search?query="+searchBar.text!
        
        print(urlString)
        
        let json = getJSONFromURL(urlString, "GET")
        let status = json["status"]
        
        // Check if status is good
        if status == 200 {
            print("good status")
            for r in json["data"].arrayValue {
                
                //returns null if its poll
                //polls dont have this attribute
                if(r["numReviews"] == JSON.null) {
                    print("poll")
                    let opts = [String]()
                    let distribution = Set<Int>()
                    let temp = Poll.init(id: r["id"].intValue, type: 2, time: r["dayLimit"].doubleValue, option: opts, distribution: distribution, votes: r["numVotes"].intValue, text: r["text"].stringValue, cat: r["categoryID"].intValue)
                    polls.append(temp)
                }
                else {
                    print("review")
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
        print(param + ":" + String(topics.count+polls.count))
    }
}
