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
    weak var delegate : GenericStruct?
    
    init(nib : UINib, identifier: String, father: String?, delegate: GenericStruct? = nil) {
        self.nib = nib
        self.identifier = identifier
        self.father = father
        self.delegate = delegate
    }
    
}

class BaseModel: NSObject {
    
    var cells : [BaseCellStruct]!
    var titleViewController : String!
    var touchForCloseKeyboard : Bool = false
    var resizeForKeyboard : Bool = false
    var centerViewController : Bool = false
    var scrollingViewController : Bool = true
    var bounceViewController : Bool = true
    var rightBarButtonItems : [UIBarButtonItem]!
    var leftBarButtonItems : [UIBarButtonItem]!
    var hideNavigationBar : Bool = false
    var backgroudImage : UIImage? = nil
    weak var delegate : LoadWidgetsDelegate?
    
    override init() {
        super.init()
        
        cells = []
        titleViewController = ""
        
        rightBarButtonItems = []
        leftBarButtonItems = []
        
    }
    
    func setupDelegate(delegate: LoadWidgetsDelegate? = nil) {
        self.delegate = delegate
    }

}

@objc protocol GenericStruct : class {
}

@objc protocol LoadWidgetsDelegate : GenericStruct {
    @objc optional func loadWidget()
    func selectedCell(index: IndexPath)
    @objc optional func deinitListener()
}
