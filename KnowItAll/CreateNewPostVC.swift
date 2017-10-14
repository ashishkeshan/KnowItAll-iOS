//
//  CreateNewPostVC.swift
//  KnowItAll
//
//  Created by Ashish Keshan on 10/5/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit
import Cosmos

class CreateNewPostVC: UIViewController {

    @IBOutlet weak var segementedControl: UISegmentedControl!
    
    @IBOutlet weak var academic: UIButton!
    @IBOutlet weak var food: UIButton!
    @IBOutlet weak var entertain: UIButton!
    @IBOutlet weak var location: UIButton!
    @IBOutlet weak var create: UIButton!
    
    @IBOutlet weak var reviewPage: UIView!
    
    
    //fields to send to backend
    var category:Int?
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var ratings: CosmosView!
    @IBOutlet weak var comment: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //stars set up
        ratings.settings.updateOnTouch = true
        ratings.settings.fillMode = .full
        ratings.settings.starSize = 30
        ratings.rating = 0
        
        //optional comment set up
        comment.delegate = self
        comment.text = "Optional Comments"
        comment.textColor = UIColor.lightGray
        
        //rounded edges for create button
        create.layer.cornerRadius = 5
        create.layer.borderWidth = 1
        create.layer.borderColor = UIColor.red.cgColor
    }


    //button press functions
    @IBAction func pressed1(_ sender: UIButton) {
        category = 1
        academic.alpha = 1.0
        food.alpha = 0.5
        entertain.alpha = 0.5
        location.alpha = 0.5
    }
    @IBAction func pressed2(_ sender: UIButton) {
        category = 2
        academic.alpha = 0.5
        food.alpha = 1.0
        entertain.alpha = 0.5
        location.alpha = 0.5
    }
    @IBAction func pressed3(_ sender: UIButton) {
        category = 3
        academic.alpha = 0.5
        food.alpha = 0.5
        entertain.alpha = 1.0
        location.alpha = 0.5
    }
    @IBAction func pressed4(_ sender: UIButton) {
        category = 4
        academic.alpha = 0.5
        food.alpha = 0.5
        entertain.alpha = 0.5
        location.alpha = 1.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segementedControl.selectedSegmentIndex {
        case 0:
            reviewPage.isHidden = false
//            popularView.isHidden = false
            break;
        case 1:
            reviewPage.isHidden = true
//            historyView.isHidden = false
            break;
        default:
            break;
        }
    }
}

extension CreateNewPostVC: UITextViewDelegate {
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
