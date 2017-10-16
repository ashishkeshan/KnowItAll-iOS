//
//  PollVC.swift
//  KnowItAll
//
//  Created by Ashish Keshan on 10/14/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class PollVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var screenWidth = CGFloat(0.0)
    var prevSelected : IndexPath? = nil
    var poll : Poll? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        screenWidth = UIScreen.main.bounds.size.width
        print("num votes: ", poll?.numVotes)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // change when integrated with backend to use indexPath.row inside data model arrays
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PollOptionCell", for: indexPath) as! PollOptionCell
        let frame = cell.percentFilled.frame
        switch indexPath.row {
        case 0:
            cell.optionName.text = "Blaze"
            cell.optionPercent.text = "50%"
            cell.percentFilled.backgroundColor = UIColor(red:0.77, green:0.12, blue:0.23, alpha:1.0)
            cell.percentFilled.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: screenWidth * 0.5, height: frame.size.height)
        case 1:
            cell.optionName.text = "Pizza Studio"
            cell.optionPercent.text = "20%"
            cell.percentFilled.backgroundColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
            cell.percentFilled.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: screenWidth * 0.2, height: frame.size.height)
        case 2:
            cell.optionName.text = "Domino's"
            cell.optionPercent.text = "10%"
            cell.percentFilled.backgroundColor = UIColor(red:1.00, green:0.80, blue:0.40, alpha:1.0)
            cell.percentFilled.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: screenWidth * 0.1, height: frame.size.height)
        case 3:
            cell.optionName.text = "Pizza Hut"
            cell.optionPercent.text = "15%"
            cell.percentFilled.backgroundColor = UIColor(red:0.29, green:0.65, blue:0.49, alpha:1.0)
            cell.percentFilled.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: screenWidth * 0.15, height: frame.size.height)
        case 4:
            cell.optionName.text = "California Pizza Kitchen"
            cell.optionPercent.text = "5%"
            cell.percentFilled.backgroundColor = UIColor(red:1.00, green:0.58, blue:0.00, alpha:1.0)
            cell.percentFilled.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: screenWidth * 0.05, height: frame.size.height)
        default:
            break
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if prevSelected != nil {
            let oldSelectionCell = tableView.cellForRow(at: prevSelected!) as! PollOptionCell
            oldSelectionCell.optionPercent.textColor = UIColor.lightGray
            oldSelectionCell.optionName.textColor = UIColor.lightGray
        }
        prevSelected = indexPath
        let cell = tableView.cellForRow(at: indexPath) as! PollOptionCell
        cell.optionPercent.textColor = UIColor.black
        cell.optionName.textColor = UIColor.black
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
