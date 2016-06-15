//
//  HonoreeTableViewCell.swift
//  Scroll_of_Honor
//
//  Created by Daniel Hernandez on 11/23/15.
//  Copyright © 2015 Garofalo. All rights reserved.
//

import UIKit

class HonoreeTableViewCell: UITableViewCell {
   // MARK: Properties
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var yearLabel: UILabel!
   @IBOutlet weak var rankWarLabel: UILabel!
   @IBOutlet weak var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
