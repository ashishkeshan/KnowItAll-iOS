//
//  SpecificReviewCell.swift
//  KnowItAll
//
//  Created by Toshitaka on 10/12/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit
import Cosmos

class SpecificReviewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var stars: CosmosView!
    @IBOutlet weak var comment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stars.settings.updateOnTouch = false
        stars.settings.fillMode = .precise
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
