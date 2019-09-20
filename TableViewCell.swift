//
//  TableViewCell.swift
//  FR3
//
//  Created by Michael Brewington on 11/27/18.
//  Copyright © 2018 Michael Brewington. All rights reserved.
//

import UIKit
import Foundation

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
