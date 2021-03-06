//
//  PollVC.swift
//  KnowItAll
//
//  Created by Ashish Keshan on 10/14/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

protocol PollVCDelegate {
    func refreshPage()
}

class PollVC: UIViewController, UITableViewDelegate, UITableViewDataSource, PollVCDelegate {

    @IBOutlet weak var pollTitle: UILabel!
    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var numVotes: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCommentButton: UIButton!
    var screenWidth = CGFloat(0.0)
    var prevSelected : IndexPath? = nil
    var poll : Poll? = nil
    var optionsList = [String]()
    var numVotesList = [Int]()
    var colorsArray = [UIColor]()
    var commentsList = [String]()
    var usernameList = [String]()
    var dateString = ""
    var dayLimit = 0
    var totVotes = 0
    var percent = 0.0
    var email = ""
    var pc = ""
    var idx = -1
    var flag = true
    var segueFlag = false
    var pollClosed = false

    @IBAction func addComment(_ sender: Any) {
        let email = UserDefaults.standard.object(forKey: Login.emailKey) as! String
        if email == "" {
            let alert = UIAlertController(title: "Error!", message: "You must be logged in to perform this action!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        } else {
            performSegue(withIdentifier: "presentAddCommentVC", sender: self)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100.0;
        tableView.rowHeight = UITableViewAutomaticDimension
        screenWidth = UIScreen.main.bounds.size.width
        totVotes = (poll?.numVotes)!
        colorsArray.append(UIColor(red:0.77, green:0.12, blue:0.23, alpha:1.0))
        colorsArray.append(UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0))
        colorsArray.append(UIColor(red:1.00, green:0.80, blue:0.40, alpha:1.0))
        colorsArray.append(UIColor(red:0.29, green:0.65, blue:0.49, alpha:1.0))
        colorsArray.append(UIColor(red:1.00, green:0.58, blue:0.00, alpha:1.0))
        pollTitle.text = poll?.title
        numVotes.text = String(describing: (poll?.numVotes)!) + " votes"
        setupPollTimeRemaining()
        determineUserVote()
        // Do any additional setup after loading the view.
    }
    
    func determineUserVote() {
        email = UserDefaults.standard.string(forKey: Login.emailKey)!
        let urlString = "/vote?username=\(email)&pollText=\((poll?.title)!)"
        let json = getJSONFromURL(urlString, "POST")
        let status = json["status"]
        if status == 200 {
            pc = json["pc"].string!
            for i in 0 ... optionsList.count-1 {
                if pc == optionsList[i] {
                    idx = i
                    prevSelected = IndexPath(row: idx, section: 0)
                }
            }
        }
    }
    
    func setupPollTimeRemaining() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let currDate = Date()
        let datePublished = dateFormatter.date(from: dateString)
        print(datePublished!)
        let timeInterval = currDate.timeIntervalSince(datePublished!)
        if (poll?.timeLeft == 0) {
            timeLeft.text = "Lasts forever"
        } else {
            let hours = getHoursElapsed(seconds: Int(timeInterval))
            let hoursRem = (dayLimit * 24) - hours
            if (hoursRem >= 1) {
                timeLeft.text = String(describing: hoursRem) + " Hours Left"
            } else {
                let alert = UIAlertController(title: "Alert!", message: "This poll is closed! You will not be able to vote or comment on this poll.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.addCommentButton.alpha = 0
                pollClosed = true
                timeLeft.text = "Poll Closed"
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segueFlag = true
        if segue.destination is AddCommentVC {
            let vc = segue.destination as? AddCommentVC
            vc?.pollTitle = pollTitle.text!
            vc?.delegate = self
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if !segueFlag {
            self.navigationController?.popViewController(animated: false)
        } else {
            segueFlag = false
        }
    }
    
    func getHoursElapsed(seconds: Int) -> Int {
        print("seconds: ", seconds)
        return seconds / 3600
    }
    
    func getPollInfo() {
//        http://127.0.0.1:8000/api/getPost?type=poll&text=Who is the best teammate?
        optionsList.removeAll()
        totVotes = 0
        numVotesList.removeAll()
        commentsList.removeAll()
        var urlString = "/getPost?type=poll&text=" + (poll?.title)!
        
        var json = getJSONFromURL(urlString, "GET")
        var status = json["status"]
        // Check if status is good
        if status == 200 {
            for poll in json["poll"].arrayValue {
                dateString = poll["dateCreated"].stringValue
//                let dateArr = dateString.components(separatedBy: "T")
                dayLimit = poll["dayLimit"].intValue
//                print("DATE CREATED: ", dateArr[0])
//                dateString = dateArr[0]
            }
            for option in json["pc"].arrayValue {
                optionsList.append(option["text"].stringValue)
                totVotes += option["numVotes"].int!
                numVotesList.append(option["numVotes"].int!)
            }
        }
        urlString = "/getComments?type=poll&pollText=" + (poll?.title)!
        json = getJSONFromURL(urlString, "GET")
        status = json["status"]
        if status == 200 {
            for comment in json["comments"].arrayValue {
                commentsList.append(comment["text"].stringValue)
                if comment["anonymous"] == true {
                    usernameList.append("Anonymous")
                } else {
                    let newstr = comment["username"].string!
                    var token = newstr.components(separatedBy: "@")
                    usernameList.append(token[0])
                }
            }
        }
    }
    
    func refreshPage() {
        getPollInfo()
        self.numVotes.setNeedsLayout()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsList.count + commentsList.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < optionsList.count {
            return 75.0
        }
        else if indexPath.row == optionsList.count {
            return 50.0
        }
        else {
            return UITableViewAutomaticDimension
        }
    }
    
    // change when integrated with backend to use indexPath.row inside data model arrays
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < optionsList.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PollOptionCell", for: indexPath) as! PollOptionCell
            if indexPath.row == idx && flag {
                cell.optionName.textColor = UIColor.black
                cell.optionPercent.textColor = UIColor.black
            }
            if totVotes == 0 {
                percent = 0.0
            } else {
                percent = (Double(numVotesList[indexPath.row]) / Double(totVotes))
                percent = percent.rounded(toPlaces: 4)
            }
            cell.optionName.text = optionsList[indexPath.row % colorsArray.count]
            cell.optionPercent.text = String(percent * 100) + "%"
            let frame = cell.percentFilled.frame
            cell.percentFilled.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: CGFloat(Double(screenWidth) * percent), height: frame.size.height)
            cell.percentFilled.backgroundColor = colorsArray[indexPath.row]
            return cell
        }
        else if indexPath.row == optionsList.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Divider", for: indexPath)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! PollPageCommentCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.commentLabel.text = commentsList[indexPath.row - (optionsList.count+1)]
            cell.authorLabel.text = usernameList[indexPath.row - (optionsList.count+1)]
            return cell
        }
        
       
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < optionsList.count && !pollClosed {
            let email = UserDefaults.standard.object(forKey: Login.emailKey) as! String
            if email == "" {
                let alert = UIAlertController(title: "Error!", message: "You must be logged in to perform this action!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            let urlString = "/vote?username=\(email)&pollText=" + (poll?.title)! + "&pollChoiceText=\(optionsList[indexPath.row])&deleteVote=0"
            _ = getJSONFromURL(urlString, "POST")
            if prevSelected != nil {
                flag = false
                let urlString = "/vote?username=\(email)&pollText=" + (poll?.title)! + "&pollChoiceText=\(optionsList[(prevSelected?.row)!])&deleteVote=1"
                _ = getJSONFromURL(urlString, "POST")
                numVotesList[(prevSelected?.row)!] -= 1
                totVotes -= 1
                let oldSelectionCell = tableView.cellForRow(at: prevSelected!) as! PollOptionCell
                oldSelectionCell.optionPercent.textColor = UIColor.lightGray
                oldSelectionCell.optionName.textColor = UIColor.lightGray
            }
            prevSelected = indexPath
            let cell = tableView.cellForRow(at: indexPath) as! PollOptionCell
            cell.optionPercent.textColor = UIColor.black
            cell.optionName.textColor = UIColor.black
            numVotesList[indexPath.row] += 1
            totVotes += 1
            numVotes.text = String(totVotes) + " votes"
            tableView.reloadData()
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

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
