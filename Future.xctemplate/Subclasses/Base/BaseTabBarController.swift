//
//  BaseTabBarController.swift
//
//  Created by stefano vecchiati.
//  Copyright © 2018 co.eggon. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard let tabBars = Tab_bar.readAll(), tabBars.count > 0 else { return }
//
//        let hexColor = General_app_settings.read(withIdentifier: "0")?.appColor ?? "000000"
//
//        self.tabBar.tintColor = UIColor().hexColor(hex: hexColor)
//
//        var controllers : [UIViewController] = []
//
//        for tabBar in tabBars {
//
//            guard let image = tabBar.image_name, let id = tabBar.action else { break }
//
//            guard let modelTypeString = Application_map_model.read(withIdentifier: id)?.type, let modelType = ModelType(rawValue: modelTypeString) else { break }
//
//            guard let model = loadFromModel(type: modelType, withID: id) else { break }
//
//            let viewController = ViewController(withModel: model)
//            viewController.title = tabBar.title
//            viewController.tabBarItem = UITabBarItem(title: tabBar.title, image: UIImage(named: image), selectedImage: UIImage(named: image + "-active"))
//            controllers.append(viewController)
//        }
//
//        self.viewControllers = controllers.map { BaseNavigationController(rootViewController: $0)}
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func loadFromModel(type : ModelType, withID id : String) -> BaseModel? {
//        switch type {
//        case .map_view_widget:
//            return Map_model.createModel()
//        case .web_view_widget:
//            return Web_view.createModel(withID: id)
//        case .camera_qrcode_reader:
//            let model = BaseModel()
//            model.cells = [BaseCellStruct(nib: UINib(nibName: String(describing: QRCodeReaderWidget.classForCoder()), bundle: nil), identifier: QRCodeReaderWidget.reuseIdentifier(), father: nil)]
//            model.centerViewController = true
//            model.scrollingViewController = false
//            return model
//        }
//    }
    

}
