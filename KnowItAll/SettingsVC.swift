//
//  SettingsVC.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/6/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {
    
    var settingOptions = ["Change Password", "Notifications","Rate KnowItAll","Submit Feedback","Sign Out"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingOptions.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = settingOptions[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                performSegue(withIdentifier: "changePasswordSegue", sender: self)
                break
            case 1:
                performSegue(withIdentifier: "notificationSegue", sender: self)
                break
            case 2:
                performSegue(withIdentifier: "rateSegue", sender: self)
                break
            case 3:
                performSegue(withIdentifier: "submitSegue", sender: self)
                break
            case 4:
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
            default:
                break
        }
        
        
        
    }

}
