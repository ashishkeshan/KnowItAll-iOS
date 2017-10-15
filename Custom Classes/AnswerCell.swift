//
//  AnswerCell.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/14/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {

    @IBOutlet weak var answer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
