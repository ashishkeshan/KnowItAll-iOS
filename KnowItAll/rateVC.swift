//
//  rateVC.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/12/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit
import Cosmos

class rateVC: UIViewController {
    @IBOutlet weak var stars: CosmosView!
    
    @IBAction func confirm(_ sender: Any) {
        let alert = UIAlertController(title: "Rating Confirmed", message: "Rating of \(stars.rating) has been sent", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stars.settings.updateOnTouch = true
        stars.settings.fillMode = .full
        stars.settings.starSize = 50
        stars.rating = 0
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
