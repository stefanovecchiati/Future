//
//  UnderlineButton.swift
//  Heldev
//
//  Created by stefano vecchiati on 09/11/2018.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit

class UnderlineButton: UIButton {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
 
    }
    
    func setTitle(title : String) {
        
        let attrs = [
            NSAttributedString.Key.underlineStyle : 1]
        
        let attributedString = NSMutableAttributedString(string:"")
        
        let buttonTitleStr = NSMutableAttributedString(string: title, attributes:attrs)
        attributedString.append(buttonTitleStr)
        self.setAttributedTitle(attributedString, for: .normal)
        
    }


}
