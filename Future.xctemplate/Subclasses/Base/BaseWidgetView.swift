//
//  BaseWidgetView.swift
//
//  Created by stefano vecchiati.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit

class BaseWidgetView: UIView {
    
    var clearBackgroundColors : Bool = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    func loadNib() {
        let nibView : UIView = Bundle.main.loadNibNamed(String(describing: self.classForCoder), owner: self, options: nil)?.first as! UIView
        nibView.translatesAutoresizingMaskIntoConstraints = true
        nibView.frame = self.bounds
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        nibView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(nibView)
        if(self.clearBackgroundColors){
            nibView.backgroundColor = UIColor.clear
            self.backgroundColor = UIColor.clear
        }
        setup()
    }
    
    func setup() {
        
    }
}
