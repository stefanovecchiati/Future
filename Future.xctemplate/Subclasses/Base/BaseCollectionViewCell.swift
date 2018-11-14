//
//  BaseCollectionViewCell.swift
//
//  Created by stefano vecchiati.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    var baseModel : BaseModel?
    var selectedStruct : Any?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
        
        
    }
    
    func setupCell() {
        
    }
    
}
