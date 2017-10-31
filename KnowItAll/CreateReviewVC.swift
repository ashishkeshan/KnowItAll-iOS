//
//  CreateReviewVC.swift
//  
//
//  Created by Ashish Keshan on 10/30/17.
//

import UIKit
import Cosmos

class CreateReviewVC: UIViewController {

    // make a button pressed function for each category (refer to createNewPostVC for info)
    
    @IBOutlet weak var commentsView: UITextView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var topicField: UITextField!
    @IBOutlet weak var academicView: UIView!
    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var locationsView: UIView!
    @IBOutlet weak var entertainmentView: UIView!
    
    // set alpha for all non-selected views as .5
    // fill in topicField with title of review and make it non-editable
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func anonymousTapped(_ sender: Any) {
    }
    
    @IBAction func createPressed(_ sender: Any) {
        // sent request to backend to submit the review
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
