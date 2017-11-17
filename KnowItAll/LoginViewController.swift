//
//  LoginViewController.swift
//  
//
//  Created by Ashish Keshan on 10/4/17.
//
//

import UIKit
import BCryptSwift

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var userDefaults: UserDefaults!
    
    var emailAddress = ""
    var newPassword = ""
    var salt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFields()
        userDefaults = UserDefaults.standard
    }
    
    func setupFields() {
        // Check if fields are being edited
        emailField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    
    // Check if editing
    func textFieldDidChange(textField: UITextField) {
        errorLabel.isHidden = true
    }
    
    
    @IBAction func guestLoginPressed(_ sender: Any) {
        errorLabel.alpha = 0
        userDefaults.set("", forKey: Login.emailKey)
        let storyboard = UIStoryboard(name: "TabBar", bundle:nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TabBar")
        controller.modalTransitionStyle = .flipHorizontal
        self.present(controller, animated: true, completion: nil)
    }
    // Login
    @IBAction func loginPressed(_ sender: Any) {
        errorLabel.isHidden = true
        indicator.isHidden = false
        // Fields are empty
        if emailField.text == "" || passwordField.text == "" {
            errorLabel.text = Login.emailPass
            errorLabel.isHidden = false
            indicator.isHidden = true
            return
        }
            
            // Not USC email
        else if !(emailField.text?.contains("@usc.edu"))! {
            errorLabel.text = Login.uscEmailOnly
            errorLabel.isHidden = false
            indicator.isHidden = true
            return
        }
        
        let urlString = "/authenticate?username="+emailField.text! + "&check=true"
        var json = getJSONFromURL(urlString, "GET")
        let status = json["status"]
        let authenticated = json["authenticated"].string
        let hashedPassword = json["password"].stringValue
        // Check if status is good
        if status == 200 {
            if authenticated == "true" {
                let verify = BCryptSwift.verifyPassword(passwordField.text!, matchesHash: hashedPassword)!
                if verify == true {
                    userDefaults.set(emailField.text, forKey: Login.emailKey)
                    userDefaults.set(Login.yes, forKey: Login.loggedIn)
                    // Segue
                    let storyboard = UIStoryboard(name: "TabBar", bundle:nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "TabBar")
                    controller.modalTransitionStyle = .flipHorizontal
                    self.present(controller, animated: true, completion: nil)
                } else {
                    errorLabel.text = Login.wrongPass
                    errorLabel.isHidden = false
                }
                
            } else {
                errorLabel.text = Login.notAuth
                errorLabel.isHidden = false
            }
        } else {
            errorLabel.text = "Sorry, email not found. Please sign up first."
            errorLabel.isHidden = false
            indicator.isHidden = true
            return
        }
        indicator.isHidden = true
        
    }
    
    // Sign Up
    @IBAction func signupPressed(_ sender: Any) {
        errorLabel.isHidden = true
        // Fields are empty
        if emailField.text == "" || passwordField.text == "" {
            errorLabel.text = Login.emailPass
            errorLabel.isHidden = false
            indicator.isHidden = true
            return
        }
            
            // Not USC email
        else if !(emailField.text?.contains("@usc.edu"))! {
            errorLabel.text = Login.uscEmailOnly
            errorLabel.isHidden = false
            indicator.isHidden = true
            return
        }
        let salt = BCryptSwift.generateSaltWithNumberOfRounds(4)
        let password = BCryptSwift.hashPassword(self.passwordField.text!, withSalt: salt)
        indicator.isHidden = false
        indicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            let urlString = "/register?username="+self.emailField.text!+"&password="+password!
            let json = getJSONFromURL(urlString, "POST")
            let status = json["status"]
            
            // Check if status is good
            if status == 200 {
                let alert = UIAlertController(title: "Email Authentication", message: "A verification email has been sent to \(self.emailField.text!)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    self.emailField.text = ""
                    self.passwordField.text = ""
                }))
                self.present(alert, animated: true, completion: nil)
            } // endif
            else {
                self.errorLabel.text = Login.emailExists
                self.errorLabel.isHidden = false
                self.indicator.isHidden = true
                return
            }
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
        }
    }
    
    // Forgot Password
    @IBAction func forgotPressed(_ sender: Any) {
        errorLabel.isHidden = true
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
    
    func changePassword() {
        indicator.isHidden = false
        indicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            let urlString = "/editProfile?username="+self.emailAddress+"&newPassword="+self.newPassword+"&forgot=1"
            let json = getJSONFromURL(urlString, "GET")
            let status = json["status"]
            // Check if status is good
            if status == 200 {
                let alert = UIAlertController(title: "Success", message: "Please check your email to confirm your password change.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } // endif
            else {
                let alert = UIAlertController(title: "Wrong Email Address", message: "Error, your password could not be successfully updated.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
        }
    }
}
