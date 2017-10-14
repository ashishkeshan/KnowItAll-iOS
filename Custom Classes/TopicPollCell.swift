//
//  TopicPollCell.swift
//  KnowItAll
//
//  Created by Ashish Keshan on 10/12/17.
//  Copyright © 2017 Ashish Keshan. All rights reserved.
//

import UIKit

class TopicPollCell: UITableViewCell {
    @IBOutlet weak var pollName: UILabel!
    @IBOutlet weak var pollCategoryImage: UIImageView!
    @IBOutlet weak var numVotesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
