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
    weak var delegate : GenericStruct?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if #available(iOS 12, *) { setupSelfSizingForiOS12(contentView: contentView) }
        
        setupCell()
        
        
    }
    
    func setupCell() {
        
    }
    
    func contentSetup() {
        
    }
    
}

extension UICollectionViewCell {
    /// This is a workaround method for self sizing collection view cells which stopped working for iOS 12
    func setupSelfSizingForiOS12(contentView: UIView) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
        let rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
        let topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
}
