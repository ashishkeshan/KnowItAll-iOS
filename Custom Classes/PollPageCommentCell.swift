//
//  PollPageCommentCellTableViewCell.swift
//  KnowItAll
//
//  Created by Ashish Keshan on 11/17/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit
import Cosmos

class PollPageCommentCell: UITableViewCell {

    @IBOutlet weak var hiddenRating: CosmosView! //this is so that I had something to constrain the comment label to
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.hiddenRating.alpha = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
