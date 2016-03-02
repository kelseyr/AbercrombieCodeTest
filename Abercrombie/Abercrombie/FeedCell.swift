//
//  FeedCell.swift
//  Abercrombie
//
//  Created by Kelsey Robertson on 3/2/16.
//  Copyright © 2016 CentricConsulting. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var feedTitleLabel: UILabel!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
