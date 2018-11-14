//
//  TextFieldView.swift
//  Heldev
//
//  Created by stefano vecchiati on 08/11/2018.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit

class TextFieldView: BaseWidgetView {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var line: UIView!
    
    private var placeholder : String?
    
    func setup(lineColor : UIColor, placeholder : String, keyboardType : UIKeyboardType, isSecureTextEntry : Bool = false) {
        super.setup()
        
        self.placeholder = placeholder
        
        line.backgroundColor = lineColor
        line.alpha = 0.5
        
        label.tintColor = lineColor
        
        label.isHidden = true
        
        textField.placeholder = placeholder
        label.text = placeholder
        
        textField.keyboardType = keyboardType
        
        textField.isSecureTextEntry = isSecureTextEntry
        
        textField.delegate = self
        
    }

}

extension TextFieldView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = nil
        label.isHidden = false
        line.alpha = 1
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.placeholder = placeholder

        line.alpha = 0.5
        
        guard let text = textField.text, !text.isEmpty else {
            label.isHidden = true
            return
        }
    }
    
}
