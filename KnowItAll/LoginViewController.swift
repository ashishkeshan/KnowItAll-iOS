//
//  LoginViewController.swift
//  
//
//  Created by Ashish Keshan on 10/4/17.
//
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var emailAddress = ""
    var password = ""
    var newPassword = ""
    
    @IBAction func loginPressed(_ sender: Any) {
        
    }
    @IBAction func signupPressed(_ sender: Any) {
        
    }
    @IBAction func forgotPressed(_ sender: Any) {
        // Alert
        let alert = UIAlertController(title: "Reset password", message: "Please type your email address and a new password", preferredStyle: .alert)
        
        // A - Textfield
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Email address"
        }
        
        // A - Textfield
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "New password"
            textField.isSecureTextEntry = true
        }
        
        // A - OK
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let emailTextField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.emailAddress = (emailTextField?.text)!
            
            let passwordTextField = alert?.textFields![1]
            self.newPassword = (passwordTextField?.text)!
            // Only update if new password is not empty
            if self.newPassword != "" { self.changePassword() }
        }))
        
        // A - Cancel
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func changePassword() {
        let urlString = "/editProfile?username="+emailAddress+"&newPassword="+newPassword
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
