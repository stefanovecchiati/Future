//
//  BaseModel.swift
//
//  Created by stefano vecchiati.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit

class BaseCellStruct {
    var nib : UINib!
    var identifier : String!
    var father : String?
    
    init(nib : UINib, identifier: String, father: String?) {
        self.nib = nib
        self.identifier = identifier
        self.father = father
    }
    
}

class BaseModel: NSObject {
    
    var cells : [BaseCellStruct]!
    var titleViewController : String!
    var centerViewController : Bool = false
    var scrollingViewController : Bool = true
    var rightBarButtonItems : [UIBarButtonItem]!
    var leftBarButtonItems : [UIBarButtonItem]!
    var hideNavigationBar : Bool = false
    var backgroudImage : UIImage? = nil
    
    override init() {
        super.init()
        
        cells = []
        titleViewController = ""
        
        rightBarButtonItems = []
        leftBarButtonItems = []
        
    }

}
