//
//  HomePage.swift
//  KnowItAll
//
//  Created by Ashish Keshan on 10/5/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit
import NotificationCenter

class HomePage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var academicView: UIView!
    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var entertainmentView: UIView!
    @IBOutlet weak var locationsView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    var previousOffset = CGFloat(0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self;
        tableView.delegate = self;
        let clickAcademic = UITapGestureRecognizer(target: self, action:  #selector (self.academicViewTouched (_:)))
        self.academicView.addGestureRecognizer(clickAcademic)
        let clickFood = UITapGestureRecognizer(target: self, action:  #selector (self.foodViewTouched (_:)))
        self.foodView.addGestureRecognizer(clickFood)
        let clickEntertainment = UITapGestureRecognizer(target: self, action:  #selector (self.entertainmentViewTouched (_:)))
        self.entertainmentView.addGestureRecognizer(clickEntertainment)
        let clickLocations = UITapGestureRecognizer(target: self, action:  #selector (self.locationsViewTouched (_:)))
        self.locationsView.addGestureRecognizer(clickLocations)
    }
    
    func academicViewTouched(_ sender:UITapGestureRecognizer) {
        searchBar.text = "Academic"
        self.tabBarController?.selectedIndex = 1
        let nc = NotificationCenter.default
        nc.post(name:Notification.postName(rawValue:"MyNotification"),
                object: nil,
                userInfo: ["message":"Hello there!", "date":Date()])    }
    
    func foodViewTouched(_ sender:UITapGestureRecognizer) {
        searchBar.text = "Food"
        self.tabBarController?.selectedIndex = 1
    }
    
    func entertainmentViewTouched(_ sender:UITapGestureRecognizer) {
        searchBar.text = "Entertainment"
        self.tabBarController?.selectedIndex = 1
    }
    
    func locationsViewTouched(_ sender:UITapGestureRecognizer) {
        searchBar.text = "Locations"
        self.tabBarController?.selectedIndex = 1
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.starRating.rating = 3.5
        cell.postTitle.text = "Star Wars"
        cell.numReviews.text = "30 reviews"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
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
