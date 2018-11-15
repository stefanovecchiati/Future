//
//  Created by stefano vecchiati.
//  Copyright © 2018 co.eggon. All rights reserved.
//

import UIKit

class ViewWidget: BaseCollectionViewCell {
    
    override func setupCell() {
        super.setupCell()

        
    }
    
    func setConstraint() {
        
        guard let baseModel = baseModel else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let navigationBarHeight = ( UIApplication.topViewController()?.navigationController?.navigationBar.bounds.height ?? 0 ) + UIApplication.shared.statusBarFrame.height
        
        let tabBarHeight = UIApplication.topViewController()?.tabBarController?.tabBar.bounds.height ?? 0
        
        let widthConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width)
        widthConstraint.priority = .defaultHigh
        
        let heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.height - ( (baseModel.hideNavigationBar ? UIApplication.shared.statusBarFrame.height : navigationBarHeight) + tabBarHeight ))
        heightConstraint.priority = .defaultHigh
        
        self.addConstraints([widthConstraint, heightConstraint])
        
        layoutIfNeeded()
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        setConstraint()
        
    }
    
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }

}
