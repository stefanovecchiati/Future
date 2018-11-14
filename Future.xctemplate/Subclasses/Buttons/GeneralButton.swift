//
//  GeneralButton.swift
//  Heldev
//
//  Created by stefano vecchiati on 08/11/2018.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit

class GeneralButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func styleFull(withColor color : UIColor = UIColor.hexColor(hex: GenericSettings.getObject()?.customPrimaryColor ?? "007AFF"), andTitle title : String) {
        self.backgroundColor = color
        self.layer.cornerRadius = 4
        self.tintColor = .white
        self.setTitle(title, for: .normal)
    }
    
    func styleEmpty(withColor color : UIColor = UIColor.hexColor(hex: GenericSettings.getObject()?.customPrimaryColor ?? "007AFF"), andTitle title : String) {
        
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
        self.tintColor = color
        self.setTitle(title, for: .normal)
    }

}
