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
                //signout TODO
                break
            default:
                break
        }
        
        
        
    }

}
