//
//  HowAccessWidget.swift
//  Heldev
//
//  Created by stefano vecchiati on 07/11/2018.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit

class AccessWidget: BaseCollectionViewCell {
    
    @IBOutlet weak var loginButton: GeneralButton! {
        didSet {
            loginButton.styleEmpty(andTitle: R.string.localizable.kLogin())
        }
    }
    @IBOutlet weak var signupButton: GeneralButton! {
        didSet {
            signupButton.styleFull(andTitle: R.string.localizable.kSignup())
        }
    }
    
    override func setupCell() {
        super.setupCell()
        
        
        
        
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
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
    
    @IBAction func signupAction(_ sender: Any) {
        let viewController = ViewController(withModel: SignupLoginModel.createModel(access: .signup))
        UIApplication.topViewController()?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        let viewController = ViewController(withModel: SignupLoginModel.createModel(access: .login))
        UIApplication.topViewController()?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    static func createModel() -> BaseModel? {
        
        let model = BaseModel()
        let cell = BaseCellStruct(nib:
            UINib(nibName: String(describing: AccessWidget.classForCoder()), bundle: nil),
                                  identifier: AccessWidget.reuseIdentifier(),
                                  father: nil)
        
        model.cells = [cell]
        
        model.centerViewController = false
        model.scrollingViewController = false
        model.hideNavigationBar = true
        
        return model
    }
    
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
    
}
