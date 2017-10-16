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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
        nc.post(name:Notification.Name(rawValue:"MyNotification"),
                object: nil,
                userInfo: ["query": searchBar.text!])
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        executeSearch()
        searchBar.resignFirstResponder()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicReviewCell", for: indexPath) as! TopicReviewCell
        cell.starRating.rating = 3.5
        cell.postTitle.text = "Star Wars"
        cell.numReviews.text = "30 reviews"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         performSegue(withIdentifier: "showReviewPage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PollVC {
            let vc = segue.destination as? PollVC
//            vc?.poll = self.polls[self.index]
//            vc?.getPollInfo()
        } else if segue.destination is ReviewVC {
            let vc = segue.destination as? ReviewVC
//            vc?.topic = self.topics[self.index]
//            vc?.getReviews()
        }
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
