//
//  BaseHorizontalCollectionView.swift
//
//  Created by stefano vecchiati.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit

class BaseHorizontalCollectionView: BaseCollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var heightConstant: NSLayoutConstraint!
    @IBOutlet weak var widthConstant: NSLayoutConstraint!
    
    var childCells: [BaseCellStruct] = []
    
    override func setupCell() {
        super.setupCell()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        widthConstant.constant = UIScreen.main.bounds.size.width

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 10, height: 40)
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = layout
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        childCells = baseModel?.cells.filter({ $0.father == reuseIdentifier }) ?? []
        
        var height : CGFloat = 0
        
        for cell in childCells {
            
            collectionView.register(cell.nib, forCellWithReuseIdentifier: cell.identifier)
            
            if let nibView : UIView = cell.nib.instantiate(withOwner: nil, options: nil)[0] as? UIView {
                
                let nibHeight = nibView.frame.size.height
                
                if nibHeight > height {
                
                    height = nibHeight
                    
                }
                
            }
            
        }
        
        heightConstant.constant = height
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
    
}

extension BaseHorizontalCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let baseCell = (collectionView.dequeueReusableCell(withReuseIdentifier: childCells[indexPath.item].identifier, for: indexPath))
        guard let cell = baseCell as? BaseCollectionViewCell else { return baseCell }

        cell.baseModel = baseModel
        cell.selectedStruct = childCells[indexPath.item]
        
        return cell
    }
    
    
    
    
}
