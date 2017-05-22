//
//  MyCartCell.swift
//  
//
//  Created by Mitesh Patel on 2016-04-02.
//
//

import UIKit

class MyCartCell: UITableViewCell {

    @IBOutlet weak var deleteBTN: UIButton!
    @IBOutlet weak var productIMG: UIImageView!
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var modelLBL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        productIMG.layer.cornerRadius = productIMG.frame.size.width/2
        productIMG.contentMode = .ScaleToFill
        productIMG.clipsToBounds = true
        productIMG.layer.borderWidth = 2
        productIMG.layer.borderColor = UIColor.blackColor().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   
}
