//
//  checkBoxBtn.swift
//  LoginAppTest
//
//  Created by Sachin on 2/5/18.
//  Copyright © 2018 SK. All rights reserved.
//

import UIKit

class checkBoxBtn: UIButton {

    let checkedImage = UIImage(named: "checkbox_selected")! as UIImage
    let uncheckedImage = UIImage(named: "checkbox")! as UIImage
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                
                self.setImage(uncheckedImage, for: .normal)
            } else {
                self.setImage(checkedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.isUserInteractionEnabled = false
    }
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            if isChecked == true {
                isChecked = false
            } else {
                isChecked = true
            }
        }
    }

}
