//
//  CustomTableCellTableViewCell.swift
//  LoginAppTest
//
//  Created by Sachin on 2/5/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit

class CustomTableCellTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var imgImageView:UIImageView!
    @IBOutlet weak var chkBox:checkBoxBtn!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
