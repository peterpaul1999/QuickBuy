//
//  DropDownButtonWhite.swift
//  QuickBuy
//
//  Created by Thomas Karg on 31.10.16.
//  Copyright © 2016 Thomas KArg. All rights reserved.
//

import UIKit

class DropDownButtonWhite : UIButton{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setImage(UIImage(named: "Triangle"), for: UIControlState())
        tintColor = UIColor.white
        sizeToFit()
        
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageRect(forContentRect: bounds).width, bottom: 0, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 100, bottom: -2, right: 0)
    }
}
