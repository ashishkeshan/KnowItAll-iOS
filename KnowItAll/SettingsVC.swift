//
//  SettingsVC.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/6/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {
    
    var settingOptions = ["Change Password", "Notifications","Rate KnowItAll","Submit Feedback","Report","Sign Out"]
    var settingOptions2 = ["Change Password", "Notifications","Rate KnowItAll","Submit Feedback","Report","Log In"]
    let email = UserDefaults.standard.object(forKey: Login.emailKey) as! String
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingOptions.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if email == "" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = settingOptions2[indexPath.row]
        
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = settingOptions[indexPath.row]
            
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                if email == "" {
                    let alert = UIAlertController(title: "Error!", message: "You must be logged in to perform this action!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                performSegue(withIdentifier: "changePasswordSegue", sender: self)
                break
            case 1:
                if email == "" {
                    let alert = UIAlertController(title: "Error!", message: "You must be logged in to perform this action!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                performSegue(withIdentifier: "notificationSegue", sender: self)
                break
            case 2:
                performSegue(withIdentifier: "rateSegue", sender: self)
                break
            case 3:
                performSegue(withIdentifier: "submitSegue", sender: self)
                break
            case 4:
                if email == "" {
                    let errorAlert = UIAlertController(title: "Please log in to report", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
                    
                    errorAlert.addAction(UIAlertAction(title: "Log In", style: .default, handler: { (action: UIAlertAction!) in
                        // Sign out
                        UserDefaults.standard.set(Login.no, forKey: Login.loggedIn)
                        let storyboard = UIStoryboard(name: "Main", bundle:nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                        controller.modalTransitionStyle = .flipHorizontal
                        self.present(controller, animated: true, completion: nil)
                    }))
                    
                    errorAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                        return
                    }))
                    
                    present(errorAlert, animated: true, completion: nil)
                }
                performSegue(withIdentifier: "reportSegue", sender: self)
                break;
            case 5:
                let storyboard = UIStoryboard(name: "Main", bundle:nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                controller.modalTransitionStyle = .flipHorizontal
                if email == "" {
                    self.present(controller, animated: true, completion: nil)
                    break
                }
                else {
                    let deleteAlert = UIAlertController(title: "Are you sure you want to sign out?", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
                    
                    deleteAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                        // Sign out
                        UserDefaults.standard.set(Login.no, forKey: Login.loggedIn)
                        let storyboard = UIStoryboard(name: "Main", bundle:nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                        controller.modalTransitionStyle = .flipHorizontal
                        self.present(controller, animated: true, completion: nil)
                    }))
                    
                    deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                        return
                    }))
                    present(deleteAlert, animated: true, completion: nil)
                    break
            }
            default:
                break
        }
    }
}
