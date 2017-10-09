//
//  PostCell.swift
//  KnowItAll
//
//  Created by Ashish Keshan on 10/6/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit
import Cosmos

class PostCell: UITableViewCell {
    
    @IBOutlet weak var numReviews: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var starRating: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        starRating.settings.updateOnTouch = false
        starRating.settings.fillMode = .precise
        self.selectionStyle = UITableViewCellSelectionStyle.none
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
