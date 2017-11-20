//
//  AddCommentVC.swift
//  KnowItAll
//
//  Created by Ashish Keshan on 11/19/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class AddCommentVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var anonButton: UIButton!
    var pollTitle = ""
    var delegate: PollVCDelegate?
    var anonymous:Int = 0

    @IBOutlet weak var submitButton: UIButton!
    @IBAction func anonymousTapped(_ sender: Any) {
        if(anonymous == 0) {
            anonButton.backgroundColor = UIColor.blue
            anonButton.layer.borderColor = UIColor.blue.cgColor
            anonymous = 1
        }
        else {
            anonButton.backgroundColor = submitButton.backgroundColor
            anonButton.layer.borderColor = submitButton.backgroundColor?.cgColor
            anonymous = 0
        }
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        if textView.textColor == UIColor.lightGray || textView.text == nil {
            let alert = UIAlertController(title: "Error!", message: "Your comment must not be empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let email = UserDefaults.standard.object(forKey: Login.emailKey) as! String
            let c = textView.text!
            let urlString = "/createComment?username=\(email)&pollText=\(pollTitle)&comment=\(c)&anonymous=\(anonymous)"
            print("anonymous: ", anonymous)
            let json = getJSONFromURL(urlString, "POST")
            let status = json["status"]
            if status == 200 {
                let alert = UIAlertController(title: "Success", message: "Your comment has been successfully added", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (handler) in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
                //clear textfield
                textView.text = nil
                delegate?.refreshPage()
            } else {
                let alert = UIAlertController(title: "Error", message: "Error, you've already commented on this topic.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (handler) in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.text = "Example: I selected CSCI 310 as my favorite class because I learned a lot of applicable things. For example, I am working on an awesome iOS app and learning a lot! Everyone should take this class if they can."
        textView.textColor = UIColor.lightGray
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.red.cgColor
        
        anonButton.layer.cornerRadius = 5
        anonButton.layer.borderWidth = 1
        anonButton.layer.borderColor = UIColor.red.cgColor
        anonButton.setTitleColor(UIColor.darkGray, for: UIControlState.disabled)

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
            textView.text = "Example: I selected CSCI 310 as my favorite class because I learned a lot of applicable things. For example, I am working on an awesome iOS app and learning a lot! Everyone should take this class if they can."
            textView.textColor = UIColor.lightGray
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
