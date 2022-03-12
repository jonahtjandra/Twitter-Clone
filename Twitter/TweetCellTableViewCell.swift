//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Jonah Tjandra on 3/11/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetImage: UIImageView!
    
    @IBOutlet weak var tweetName: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        tweetLabel.sizeToFit()
    }

}
