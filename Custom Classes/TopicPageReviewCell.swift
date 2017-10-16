//
//  TopicPageReviewCell.swift
//  KnowItAll
//
//  Created by Ashish Keshan on 10/15/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit
import Cosmos

class TopicPageReviewCell: UITableViewCell {

    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var comment: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.rating.settings.updateOnTouch = false
        self.rating.settings.fillMode = .precise
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
