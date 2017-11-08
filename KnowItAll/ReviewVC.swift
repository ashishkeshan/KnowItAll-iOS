//
//  ReviewVC.swift
//  KnowItAll
//
//  Created by Ashish Keshan on 10/14/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit
import Cosmos

protocol ReviewVCDelegate {
    func refreshPage()
}

class ReviewVC: UIViewController, UITableViewDelegate, UITableViewDataSource, ReviewVCDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numReviews: UILabel!
    @IBOutlet weak var stars: CosmosView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var topic : Topic? = nil
    var comments = [String]()
    var ratings = [Double]()
    var segueFlag = false
    var category = -1
    let nc = NotificationCenter.default
    @IBAction func addReview(_ sender: Any) {
        let email = UserDefaults.standard.object(forKey: Login.emailKey) as! String
        if email == "" {
            let alert = UIAlertController(title: "Error!", message: "You must be logged in to perform this action!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        } else {
            performSegue(withIdentifier: "popoverSegue", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segueFlag = true
        print("seguing")
        if segue.destination is CreateReviewVC {
            let vc = segue.destination as? CreateReviewVC
            vc?.category = category
            vc?.topicName = (topic?.title)!
            vc?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100.0;
        tableView.rowHeight = UITableViewAutomaticDimension
        titleLabel.text = topic?.title
        numReviews.text = String(describing: (topic?.numReviews)!) + " review(s)"
        stars.rating = (topic?.rating)!
        stars.settings.fillMode = .half
        switch (topic?.category)! {
        case 1:
            category = 1
            let img = UIImage(named: "Academic")
            categoryImage.image = img
            break
        case 2:
            category = 2
            let img = UIImage(named: "Food")
            categoryImage.image = img
            break
        case 3:
            category = 3
            let img = UIImage(named: "Entertainment")
            categoryImage.image = img
            break
        case 4:
            category = 4
            let img = UIImage(named: "Locations")
            categoryImage.image = img
            break
        default:
            break
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if !segueFlag {
           self.navigationController?.popViewController(animated: false)
        } else {
            segueFlag = false
        }
    }
    
    func refreshPage() {
        numReviews.text = String(describing: (topic?.numReviews)!) + " review(s)"
        getReviews()
        tableView.reloadData()
    }
    
    func getReviews() {
//        http://127.0.0.1:8000/api/getPost?type=topic&text=CSCI 310
        comments.removeAll()
        ratings.removeAll()
        let urlString = "/getPost?type=topic&text=" + (topic?.title)!
        
        let json = getJSONFromURL(urlString, "GET")
        let status = json["status"]
        // Check if status is good
        if status == 200 {
            for review in json["reviews"].arrayValue {
                comments.append(review["comment"].string!)
                ratings.append(Double(review["rating"].stringValue)!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! TopicPageReviewCell
        cell.comment.text = comments[indexPath.row]
        cell.rating.rating = ratings[indexPath.row]
        return cell
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
