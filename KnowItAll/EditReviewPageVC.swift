//
//  EditReviewPageVC.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/30/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit
import Cosmos

class EditReviewPageVC: UIViewController {

    var review:Review?
    var category:Int!
    var parentVC:UIViewController!
    
    @IBOutlet weak var reviewName: UILabel!
    @IBOutlet weak var academic: UIView!
    @IBOutlet weak var location: UIView!
    @IBOutlet weak var entertainment: UIView!
    @IBOutlet weak var food: UIView!
    @IBOutlet weak var ratings: CosmosView!
    @IBOutlet weak var topic: UITextField!
    @IBOutlet weak var reviewField: UITextView!
    @IBOutlet weak var create: UIButton!
    @IBOutlet weak var anonymousButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //stars set up
        ratings.settings.updateOnTouch = true
        ratings.settings.fillMode = .full
        ratings.settings.starSize = 30
        ratings.rating = review!.rating
        
        //rounded edges for create and anonymous button
        create.layer.cornerRadius = 5
        create.layer.borderWidth = 1
        create.layer.borderColor = UIColor.red.cgColor
        anonymousButton.layer.cornerRadius = 5
        anonymousButton.layer.borderWidth = 1
        
        if(review?.anonymous == 0) {
            anonymousButton.layer.borderColor = UIColor.red.cgColor
            anonymousButton.setTitleColor(UIColor.darkGray, for: UIControlState.disabled)
        }
        else {
            anonymousButton.backgroundColor = UIColor.blue
            anonymousButton.layer.borderColor = UIColor.blue.cgColor
        }
        
        topic.text = review!.topic
        topic.isUserInteractionEnabled = false
        
        reviewField.delegate = self
        if review!.comment == "" {
            reviewField.text = "Optional Comments"
            reviewField.textColor = UIColor.lightGray
        }
        else {
            reviewField.text = review!.comment
        }
        
        switch category {
        case 1:
            academic.alpha = 1.0
            food.alpha = 0.5
            entertainment.alpha = 0.5
            location.alpha = 0.5
            break
        case 2:
            academic.alpha = 0.5
            food.alpha = 1.0
            entertainment.alpha = 0.5
            location.alpha = 0.5
            break
        case 3:
            academic.alpha = 0.5
            food.alpha = 0.5
            entertainment.alpha = 1.0
            location.alpha = 0.5
            break
        case 4:
            academic.alpha = 0.5
            food.alpha = 0.5
            entertainment.alpha = 0.5
            location.alpha = 1.0
            break
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func updatePressed(_ sender: Any) {
        //…/editPost?username=shenjona@usc.edu&type=review&topicTitle=Wonder Woman&rating=4.5&comment=Good movie
        let email = UserDefaults.standard.object(forKey: Login.emailKey) as! String
        let r = String(ratings.rating)
        let t = review!.topic
        var c = ""
        if reviewField.text! != "Optional Comments" {
            c = reviewField.text!
        }
        var anonymous = "0"
        if anonymousButton.backgroundColor == UIColor.blue {
            anonymous = "1"
        }
        
        if(category == -1) {
            let alert = UIAlertController(title: "Warning!", message: "Please select a category by pressing one of the images", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if(r == "0.0") {
            let alert = UIAlertController(title: "Warning!", message: "Please select a rating between 1-5 stars", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if(t == "") {
            let alert = UIAlertController(title: "Warning!", message: "Please enter a Topic", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //making query call to create review
        var urlString = "/editPost?username="+email+"&type=review&topicTitle="
        urlString += t!+"&rating="+r+"&comment="+c+"&anonymous="+anonymous
        
        
        let json = getJSONFromURL(urlString, "POST")
        let status = json["status"]
        
        // Check if status is good
        if status == 200 {
            let alert = UIAlertController(title: "Success", message: "Your review has been successfully updated", preferredStyle: .alert)
            let doneAction = UIAlertAction(title: "Done", style: .default) { (action: UIAlertAction!) -> Void in
                self.navigationController!.popToRootViewController(animated: true);
            }
            alert.addAction(doneAction)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Failed!", message: "Error, failed to update review.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func anonymousPressed(_ sender: Any) {
        if anonymousButton.backgroundColor != UIColor.blue {
            anonymousButton.backgroundColor = UIColor.blue
            anonymousButton.layer.borderColor = UIColor.blue.cgColor
        }
        else {
            anonymousButton.backgroundColor = create.backgroundColor
            anonymousButton.layer.borderColor = create.backgroundColor?.cgColor
        }
    }
    
    
}

extension EditReviewPageVC: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n")
        {
            self.view.endEditing(true);
            return false;
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Optional Comments"
            textView.textColor = UIColor.lightGray
        }
    }
}
