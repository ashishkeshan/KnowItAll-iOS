//
//  ChangePassword.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/6/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class ChangePassword: UIViewController {
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    var email: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFields()
        email = UserDefaults.standard.object(forKey: Login.emailKey) as! String

    }
    
    func setupFields() {
        // Check if fields are being edited
        oldPassword.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        newPassword.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        confirmPassword.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    
    // Check if editing
    func textFieldDidChange(textField: UITextField) {
        errorLabel.isHidden = true
    }
    
    @IBAction func confirmPressed(_ sender: Any) {
        let op = oldPassword.text
        let np = newPassword.text
        let cp = confirmPassword.text
        
        // Fields not filled in
        if op == "" || np == "" || cp == "" {
            errorLabel.text = "Sorry, fields cannot be blank."
            errorLabel.isHidden = false
            return
        }
        
        // Passwords didn't match
        if np != cp {
            errorLabel.text = "Sorry, passwords did not match."
            errorLabel.isHidden = false
            return
        }
        
        // Check old password
        let authString = "/login?username="+email+"&password="+op!
        print(authString)
        let json = getJSONFromURL(authString, "POST")
        
        // Old password is incorrect
        if json["status"] != 200 {
            errorLabel.text = "Sorry, old password is incorrect."
            errorLabel.isHidden = false
            return
        }
        else {
            // Update password
            let urlString = "/editProfile?username="+email+"&newPassword="+np!
            let json = getJSONFromURL(urlString, "POST")
            let status = json["status"]
            // Check if status is good
            if status == 200 {
                let alert = UIAlertController(title: "Success", message: "Your password has successfully been updated!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } // endif
            else {
                let alert = UIAlertController(title: "Wrong Email Address", message: "Error, your password could not be successfully updated.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
