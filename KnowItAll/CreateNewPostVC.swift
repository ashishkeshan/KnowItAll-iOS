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
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ratings: CosmosView!
    @IBOutlet weak var comment: UITextView!
    
    //fields to send to backend
    var category:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //stars set up
        ratings.settings.updateOnTouch = true
        ratings.settings.fillMode = .full
        ratings.settings.starSize = 35
        ratings.rating = 0
        
        //optional comment set up
        comment.delegate = self
        comment.text = "Optional Comments"
        comment.textColor = UIColor.lightGray
    }



    @IBAction func pressed1(_ sender: UIButton) {
        category = 1
        academic.backgroundColor = UIColor.red
        food.backgroundColor = UIColor.white
        entertain.backgroundColor = UIColor.white
        location.backgroundColor = UIColor.white
        print(category)
    }
    @IBAction func pressed2(_ sender: UIButton) {
        category = 2
        food.backgroundColor = UIColor.red
        entertain.backgroundColor = UIColor.white
        location.backgroundColor = UIColor.white
        academic.backgroundColor = UIColor.white
        print(category)
    }
    @IBAction func pressed3(_ sender: UIButton) {
        category = 3
        entertain.backgroundColor = UIColor.yellow
        food.backgroundColor = UIColor.white
        location.backgroundColor = UIColor.white
        academic.backgroundColor = UIColor.white
        print(category)
    }
    @IBAction func pressed4(_ sender: UIButton) {
        category = 4
        location.backgroundColor = UIColor.yellow
        food.backgroundColor = UIColor.white
        entertain.backgroundColor = UIColor.white
        academic.backgroundColor = UIColor.white
        print(category)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segementedControl.selectedSegmentIndex {
        case 0:
            print(0)
//            historyView.isHidden = true
//            popularView.isHidden = false
            break;
        case 1:
            print(1)
//            historyView.isHidden = false
//            popularView.isHidden = true
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
