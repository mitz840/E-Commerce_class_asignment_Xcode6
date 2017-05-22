//
//  HeaderCell.swift
//  
//
//  Created by Mitesh Patel on 2016-03-29.
//
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var modelLBL: UILabel!
    @IBOutlet weak var quantityLBL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var priceLBL: UILabel!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
