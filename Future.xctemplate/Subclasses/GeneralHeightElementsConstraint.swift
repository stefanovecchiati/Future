//
//  GeneralHeightElementsConstraint.swift
//  Heldev
//
//  Created by stefano vecchiati on 08/11/2018.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit

class GeneralHeightElementsConstraint: NSLayoutConstraint {
    
    override var constant : CGFloat {
        set {
            super.constant = newValue
        }
        get {
            return customConstant()
        }
        
    }
    
    
    private func customConstant() -> CGFloat {
        
        guard let genericSettings = GenericSettings.getObject() else { return 30 }
        
        if (UIDevice().type != .iPhone5S && UIDevice().type != .iPhoneSE && UIDevice().type != .simulator) || UIScreen.main.bounds.height > 568.0 {
            return genericSettings.heightElementStandardConstraint
        } else {
            return genericSettings.heightElementOldIphonesConstraint
        }
        
    }
    
    
}


