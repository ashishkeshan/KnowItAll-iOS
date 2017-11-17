//
//  ReportVC.swift
//  KnowItAll
//
//  Created by Toshitaka on 11/17/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class ReportVC: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var comments: UITextView!
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    
    var pickerData:[String] = ["Inappropriate Review","Inappropriate Poll","Inappropriate Comment","Inappropriate Tag","Bugs"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comments.delegate = self
        comments.text = "Enter feedback here"
        comments.textColor = UIColor.lightGray
        
        confirm.layer.cornerRadius = 15
        confirm.layer.borderWidth = 1
        confirm.layer.borderColor = UIColor.red.cgColor
        confirm.setTitleColor(UIColor.darkGray, for: UIControlState.disabled)
        
        self.picker.delegate = self
        self.picker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clearText() -> Void {
        comments.text = "Enter comments here"
        comments.textColor = UIColor.lightGray
        self.comments.endEditing(true);
    }
    
    @IBAction func confirmPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Report Confirmed", message: "Report has been sent", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            self.clearText()
            alert.dismiss(animated: false, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}

extension ReportVC: UITextViewDelegate {
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
            textView.text = "Enter comments here"
            textView.textColor = UIColor.lightGray
        }
    }
}
