//
//  BaseColletcionView.swift
//
//  Created by stefano vecchiati.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit

class BaseColletcionView: UICollectionView {
    
    func setupCollection(withModel model : BaseModel) {
        
        self.backgroundColor = .clear
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isScrollEnabled = model.scrollingViewController
        
        self.alwaysBounceVertical = model.bounceViewController
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 10, height: 40)
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 10
        self.collectionViewLayout = layout
        
    }
    
    public func reloadDataAndKeepOffset() {
        // stop scrolling
        setContentOffset(contentOffset, animated: false)
        
        // calculate the offset and reloadData
        let beforeContentSize = contentSize
        reloadData()
        layoutIfNeeded()
        let afterContentSize = contentSize
        
        // reset the contentOffset after data is updated
        let newOffset = CGPoint(
            x: contentOffset.x + (afterContentSize.width - beforeContentSize.width),
            y: contentOffset.y + (afterContentSize.height - beforeContentSize.height))
        setContentOffset(newOffset, animated: false)
    }
    
    private var shouldInvalidateLayout = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if shouldInvalidateLayout {
            collectionViewLayout.invalidateLayout()
            shouldInvalidateLayout = false
        }
    }
    
    override func reloadData() {
        shouldInvalidateLayout = true
        super.reloadData()
    }
    
    deinit {
        
    }
    
}
