//
//  PollOptionCell.swift
//  KnowItAll
//
//  Created by Ashish Keshan on 10/14/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class PollOptionCell: UITableViewCell {
    @IBOutlet weak var optionName: UILabel!
    @IBOutlet weak var optionPercent: UILabel!
    @IBOutlet weak var percentFilled: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
