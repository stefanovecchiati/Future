//
//  BaseNavigationController.swift
//
//  Created by stefano vecchiati.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        self.navigationBar.backIndicatorImage = R.image.back()
        self.navigationBar.backIndicatorTransitionMaskImage = R.image.back()

        if #available(iOS 11.0, *) {
            if (UIDevice().type != .iPhone5S && UIDevice().type != .iPhoneSE && UIDevice().type != .simulator) || UIScreen.main.bounds.height > 568.0 {
                self.navigationBar.prefersLargeTitles = true
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension BaseNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
    
}
