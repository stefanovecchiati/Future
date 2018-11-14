//
//  GeneralUtils.swift
//
//  Created by stefano vecchiati.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit

class GeneralUtils: NSObject {
    
    static let share = GeneralUtils()
    
    func alertBuilder(title: String?, message: String?, style : UIAlertController.Style = .alert, withAction action : Bool = true, actionTitle : [String] = [R.string.localizable.kOkay()], closeAction: @escaping (Int) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        if action {
            for (index, buttonTitle) in actionTitle.enumerated() {
                
                let button = UIAlertAction(title: buttonTitle, style: .default, handler: { action in
                    closeAction(index)
                })
                
                alert.addAction(button)
            }
        }
        
        if let stringColor = GenericSettings.getObject()?.customPrimaryColor {
            alert.view.tintColor = UIColor.hexColor(hex: stringColor)
        }
        
        
        
        return alert
    }
    
    
}
