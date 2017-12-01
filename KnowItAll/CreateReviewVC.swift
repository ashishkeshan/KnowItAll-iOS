//
//  CreateReviewVC.swift
//  
//
//  Created by Ashish Keshan on 10/30/17.
//

import UIKit
import Cosmos
import SwiftyJSON

class CreateReviewVC: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // make a button pressed function for each category (refer to createNewPostVC for info)
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var anonButton: UIButton!
    var delegate: ReviewVCDelegate?
    
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var commentsView: UITextView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var topicField: UITextField!
    @IBOutlet weak var academicView: UIView!
    @IBOutlet weak var foodView: UIView!
    @IBOutlet weak var locationsView: UIView!
    @IBOutlet weak var entertainmentView: UIView!
    @IBOutlet weak var optionalImage: UIImageView!
    
    //fields to send to backend
    var category:Int = -1
    var anonymous:Int = 0
    var topicName = ""
    let imagePicker = UIImagePickerController()
    var pictureSelected = 0
    
    // set alpha for all non-selected views as .5
    // fill in topicField with title of review and make it non-editable
    
    @IBAction func addImagePressed(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        pictureSelected = 1
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        optionalImage.contentMode = .scaleAspectFit //3
        optionalImage.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func anonymousTapped(_ sender: Any) {
        if(anonymous == 0) {
            anonButton.alpha = 1.0
            anonymous = 1
        }
        else {
            anonButton.alpha = 0.5
            anonymous = 0
        }
    }
    
    @IBAction func createPressed(_ sender: Any) {
        let email = UserDefaults.standard.object(forKey: Login.emailKey) as! String
        let r = String(ratingView.rating)
        let t = topicField.text!
        let c = commentsView.text!
        if(r == "0.0") {
            let alert = UIAlertController(title: "Warning!", message: "Please select a rating between 1-5 stars", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let stringAnon = String(anonymous)
        let urlString = "/createReview?username=\(email)&topicTitle=\(t)&rating=\(r)&comment=\(c)&anonymous=\(stringAnon)&image=0"
//        let base64String = imageData!.base64EncodedString()
//        let param : [String : Any] = ["image":base64String]
//        let jsonData = try? JSONSerialization.data(withJSONObject : param)
        var json = JSON.null
        var status = 0
        json = getJSONFromURL(urlString, "POST")
        status = json["status"].intValue
        // Check if status is good
        if status == 200 {
            let alert = UIAlertController(title: "Success", message: "Your review has been successfully submitted", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (handler) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            //clear textfield
            ratingView.rating = 0
            topicField.text = ""
            commentsView.text = ""
            category = -1
            delegate?.refreshPage()
        } // endif
        else {
            let alert = UIAlertController(title: "Data Exists", message: "Error, you've already reviewed this topic.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (handler) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        // sent request to backend to submit the review
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        commentsView.delegate = self
        commentsView.text = "Optional Comments"
        commentsView.textColor = UIColor.lightGray
        
        createButton.layer.cornerRadius = 5
        createButton.layer.borderWidth = 1
        createButton.layer.borderColor = UIColor.red.cgColor
        
        anonButton.layer.cornerRadius = 5
        anonButton.layer.borderWidth = 1
        anonButton.layer.borderColor = UIColor.red.cgColor
        anonButton.setTitleColor(UIColor.darkGray, for: UIControlState.disabled)
        
        topicField.text = topicName
        topicField.isUserInteractionEnabled = false
        pageTitle.text = "Review " + topicName
        
        switch(category) {
        case 1:
            setAcademic()
            break
        case 2:
            setFood()
            break
        case 3:
            setEntertainment()
            break
        case 4:
            setLocation()
            break
        default:
            break
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func setAcademic() {
        academicView.alpha = 1.0
        foodView.alpha = 0.5
        entertainmentView.alpha = 0.5
        locationsView.alpha = 0.5
    }
    func setFood() {
        academicView.alpha = 0.5
        foodView.alpha = 1.0
        entertainmentView.alpha = 0.5
        locationsView.alpha = 0.5
    }
    func setEntertainment() {
        academicView.alpha = 0.5
        foodView.alpha = 0.5
        entertainmentView.alpha = 1.0
        locationsView.alpha = 0.5
    }
    func setLocation() {
        academicView.alpha = 0.5
        foodView.alpha = 0.5
        entertainmentView.alpha = 0.5
        locationsView.alpha = 1.0
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
