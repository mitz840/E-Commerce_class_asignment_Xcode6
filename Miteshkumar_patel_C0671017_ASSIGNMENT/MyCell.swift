//
//  MyCell.swift
//  
//
//  Created by Mitesh Patel on 2016-03-28.
//
//

import UIKit

class MyCell: UITableViewCell {

    @IBOutlet weak var modelLBL: UILabel!
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var quantityLBL: UILabel!
    @IBOutlet weak var modelIMG: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

        modelIMG.layer.cornerRadius = modelIMG.frame.size.width/2
        modelIMG.contentMode = .ScaleToFill
        modelIMG.clipsToBounds = true
        modelIMG.layer.borderWidth = 2
        modelIMG.layer.borderColor = UIColor.blackColor().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
