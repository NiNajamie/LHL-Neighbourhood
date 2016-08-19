//
//  Cell.swift
//  LHL-Neighbourhood
//
//  Created by reena on 11/08/16.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postManager: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      //configure the view for the selected state
    }

}
