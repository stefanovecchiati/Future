//
//  BaseColletcionView.swift
//
//  Created by stefano vecchiati.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit

class BaseColletcionView: UICollectionView {

    func setupCollection(withModel model : BaseModel) {
        
//        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = .clear
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isScrollEnabled = model.scrollingViewController
        
        self.alwaysBounceVertical = true
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 10, height: 40)
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 10
        self.collectionViewLayout = layout
        
    }

}
