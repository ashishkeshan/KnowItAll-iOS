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

    @IBOutlet weak var anonymousButton: UIButton!
    @IBOutlet weak var segementedControl: UISegmentedControl!
    
    @IBOutlet weak var academic: UIView!
    @IBOutlet weak var food: UIView!
    @IBOutlet weak var entertain: UIView!
    @IBOutlet weak var location: UIView!
    @IBOutlet weak var create: UIButton!
    
    @IBOutlet weak var reviewPage: UIView!
    @IBOutlet weak var pollPage: UIView!
    
    //fields to send to backend
    var category:Int = -1
    var anonymous:Bool = false;
    //poll fields
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var answer: UITextField!
    var choices = [String]()
    var forever = false;
    @IBOutlet weak var time: UITextField!
    
    //review fields
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var ratings: CosmosView!
    @IBOutlet weak var comment: UITextView!
    
    //poll set up
    @IBOutlet weak var foreverButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var table: UITableView!

    var topic = ""
    var catId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableview set up
        table.delegate = self
        table.dataSource = self
        
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
        
        //poll buttons set up
        foreverButton.layer.cornerRadius = 15
        foreverButton.layer.borderWidth = 1
        foreverButton.layer.borderColor = UIColor.red.cgColor
        addButton.layer.cornerRadius = 15
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.red.cgColor
        addButton.setTitleColor(UIColor.darkGray, for: UIControlState.disabled)
        anonymousButton.layer.cornerRadius = 5
        anonymousButton.layer.borderWidth = 1
        anonymousButton.layer.borderColor = UIColor.red.cgColor
        anonymousButton.setTitleColor(UIColor.darkGray, for: UIControlState.disabled)
        
        //setting up button press actions
        let clickAcademic = UITapGestureRecognizer(target: self, action: #selector(self.pressed1(_:)))
        let clickFood = UITapGestureRecognizer(target: self, action: #selector(self.pressed2(_:)))
        let clickEntertainment = UITapGestureRecognizer(target: self, action: #selector(self.pressed3(_:)))
        let clickLocation = UITapGestureRecognizer(target: self, action: #selector(self.pressed4(_:)))
        self.academic.addGestureRecognizer(clickAcademic)
        self.food.addGestureRecognizer(clickFood)
        self.entertain.addGestureRecognizer(clickEntertainment)
        self.location.addGestureRecognizer(clickLocation)
        
        //disabling question textfield until a category is selected
        question.isUserInteractionEnabled = false
        question.isEnabled = false
        
        //prompting a selection of category for review
        typeField.text = "Please select a category first"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pressed1(nil)
        typeField.text = ""
        ratings.rating = 0
    }
    
    func fillReview(topic:String, catId : Int) {
        typeField.text = topic
        switch catId {
        case 1:
            pressed1(nil)
            break
        case 2:
            pressed2(nil)
            break
        case 3:
            pressed3(nil)
            break
        case 4:
            pressed4(nil)
            break
        default:
            break
        }
    }

    @IBAction func createPressed(_ sender: Any) {
        let email = UserDefaults.standard.object(forKey: Login.emailKey) as! String
        if email == "" {
            let alert = UIAlertController(title: "Error!", message: "You must be logged in to perform this action!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if(segementedControl.selectedSegmentIndex == 0) {
            //review
            let r = String(ratings.rating)
            print("rating: " , r)
            let t = typeField.text!
            let c = comment.text!
            
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
            
            //checking for topic
            let topicCheckUrl = "/getPost?type=topic&text="+t
            let check = getJSONFromURL(topicCheckUrl, "GET")
            let data = check["topic"]
            
            if(data.count == 0 ) {
                let createTopicUrl = "/createTopic?title="+t+"&category="+String(category)
                let create = getJSONFromURL(createTopicUrl, "POST")
                if create["status"] != 200 {
                    let alert = UIAlertController(title: "Error", message: "Error, failure to create new Topic", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
            
            //making query call to create review
            let urlString = "/createReview?username="+email+"&topicTitle="+t+"&rating="+r+"&comment="+c
            
            let json = getJSONFromURL(urlString, "POST")
            let status = json["status"]
            
            // Check if status is good
            if status == 200 {
                let alert = UIAlertController(title: "Success", message: "Your review has been successfully submitted", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                //clear textfield
                ratings.rating = 0
                typeField.text = ""
                comment.text = ""
                category = -1
            } // endif
            else {
                let alert = UIAlertController(title: "Data Exists", message: "Error, you've already reviewed this topic.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else {
            //poll
            let q = question.text!
            let c = choices.joined(separator: ",")
            var f:Int
            var d:String
            if(forever) {
                f = 1
                d = "0"
            }
            else {
                f = 0
                d = time.text!
            }
            
            if(category == -1) {
                let alert = UIAlertController(title: "Warning!", message: "Please select a category by pressing one of the images", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            if(d == "") {
                let alert = UIAlertController(title: "Warning!", message: "Please set a time or select Forever", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            if(choices.count < 2) {
                let alert = UIAlertController(title: "Warning!", message: "Please create at least 2 choices", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            if(q == "") {
                let alert = UIAlertController(title: "Warning!", message: "Please enter a question", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            var urlString = "/createPoll?username="+email+"&category="+String(category)+"&text="
            urlString += q+"&choices="+c+"&openForever="
            urlString += String(f)+"&dayLimit="+d
            
            let json = getJSONFromURL(urlString, "POST")
            let status = json["status"]
            
            // Check if status is good
            if status == 200 {
                let alert = UIAlertController(title: "Success", message: "Your poll has been successfully created", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                //clear textfield
                question.text = ""
                choices.removeAll()
                forever = false
                time.text = ""
                category = -1
                table.reloadData()
            } // endif
            else {
                let alert = UIAlertController(title: "Error!", message: "Error, failed to create poll", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //button press functions
    func pressed1(_ sender: AnyObject?) {
        category = 1
        academic.alpha = 1.0
        food.alpha = 0.5
        entertain.alpha = 0.5
        location.alpha = 0.5
        question.isUserInteractionEnabled = true
        question.isEnabled = true
    }
    func pressed2(_ sender: AnyObject?) {
        category = 2
        academic.alpha = 0.5
        food.alpha = 1.0
        entertain.alpha = 0.5
        location.alpha = 0.5
        question.isUserInteractionEnabled = true
        question.isEnabled = true
    }
    func pressed3(_ sender: AnyObject?) {
        category = 3
        academic.alpha = 0.5
        food.alpha = 0.5
        entertain.alpha = 1.0
        location.alpha = 0.5
        question.isUserInteractionEnabled = true
        question.isEnabled = true
    }
    func pressed4(_ sender: AnyObject?) {
        category = 4
        academic.alpha = 0.5
        food.alpha = 0.5
        entertain.alpha = 0.5
        location.alpha = 1.0
        question.isUserInteractionEnabled = true
        question.isEnabled = true
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segementedControl.selectedSegmentIndex {
        case 0:
            reviewPage.isHidden = false
            pollPage.isHidden = true
            break;
        case 1:
            reviewPage.isHidden = true
            pollPage.isHidden = false
            break;
        default:
            break;
        }
    }
    
    func addNewAnswer() -> Void {
        if(answer.text == "") {
            return
        }
        
        choices.append(answer.text!)
        let indexPath = IndexPath(row: choices.count-1,section:0)
        
        table.beginUpdates()
        table.insertRows(at: [indexPath], with: .automatic)
        table.endUpdates()
        view.endEditing(true)
        
        answer.text = ""
//        if(choices.count == 5) {
//            answer.text = "5 Choices Max"
//            addButton.isEnabled = false
//            addButton.backgroundColor = UIColor.lightGray
//        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        addNewAnswer()
    }

    @IBAction func foreverButtonPressed(_ sender: Any) {
        if(forever == false) {
            forever = true
            time.text = "Forever Selected"
            foreverButton.backgroundColor = UIColor.blue
            foreverButton.layer.borderColor = UIColor.blue.cgColor
        } else {
            forever = false
            time.text = ""
            foreverButton.backgroundColor = create.backgroundColor
            foreverButton.layer.borderColor = create.backgroundColor?.cgColor
        }
    }
    
    @IBAction func anonymousButtonPressed(_ sender: Any) {
        if(anonymous == false) {
            anonymousButton.backgroundColor = UIColor.blue
            anonymousButton.layer.borderColor = UIColor.blue.cgColor
            anonymous = true
        }
        else {
            anonymousButton.backgroundColor = create.backgroundColor
            anonymousButton.layer.borderColor = create.backgroundColor?.cgColor
            anonymous = false
        }
    }
}

extension CreateNewPostVC: UITextViewDelegate, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell") as! AnswerCell
        cell.answer.text = choices[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            choices.remove(at: indexPath.row)
            
            table.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            table.endUpdates()
            
            if(choices.count < 5) {
                answer.text = ""
                addButton.isEnabled = true
                addButton.backgroundColor = UIColor.red

            }
        }
    }
    
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
