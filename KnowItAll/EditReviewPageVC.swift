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
        anonymousButton.layer.borderColor = UIColor.red.cgColor
        anonymousButton.setTitleColor(UIColor.darkGray, for: UIControlState.disabled)
        
        topic.text = review!.topic
        topic.isUserInteractionEnabled = false
        
        if review!.comment == "" {
            reviewField.text = "Optional Comments"
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

}
