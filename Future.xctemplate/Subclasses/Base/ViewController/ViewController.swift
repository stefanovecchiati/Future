//
//  ViewController.swift
//
//  Created by stefano vecchiati .
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView: BaseColletcionView!
    var backgroundImage : UIImageView!
    
    private var viewModel : BaseModel!
    private var cellsToLoad : [BaseCellStruct] = []
    
    init(withModel model: BaseModel!) {
        super.init(nibName: nil, bundle: nil)
        viewModel = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel.titleViewController != nil && !viewModel.titleViewController.isEmpty {
            self.title = viewModel.titleViewController
        }
        
        self.navigationItem.rightBarButtonItems = viewModel.rightBarButtonItems
        self.navigationItem.leftBarButtonItems = viewModel.leftBarButtonItems
        
        addBackgroudImage()
        addCollectionView()
        
        cellsToLoad = viewModel.cells.filter({ $0.father == nil })
        
        for cell in cellsToLoad {
            collectionView.register(cell.nib, forCellWithReuseIdentifier: cell.identifier)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.topViewController()?.navigationController?.setNavigationBarHidden(viewModel.hideNavigationBar, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewModel.centerViewController {
            collectionView.contentInset.top = max((collectionView.frame.height - collectionView.contentSize.height) / 2, 0)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addBackgroudImage() {
        backgroundImage = UIImageView(image: viewModel.backgroudImage)
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        let leftConstraint = NSLayoutConstraint(item: backgroundImage, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        leftConstraint.priority = .defaultHigh
        
        let rightConstraint = NSLayoutConstraint(item: backgroundImage, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        rightConstraint.priority = .defaultHigh
        
        let topConstraint = NSLayoutConstraint(item: backgroundImage, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        topConstraint.priority = .defaultHigh
        
        let bottomConstraint = NSLayoutConstraint(item: backgroundImage, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        bottomConstraint.priority = .defaultHigh
        
        view.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
    
    private func addCollectionView() {
        
        collectionView = BaseColletcionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout.init())
        view.addSubview(collectionView)
        
        //        collectionView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.setupCollection(withModel: viewModel)
        
        
        let leftConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        leftConstraint.priority = .defaultHigh
        
        let rightConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        rightConstraint.priority = .defaultHigh
        
        let topConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        topConstraint.priority = .defaultHigh
        
        let bottomConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        bottomConstraint.priority = .defaultHigh
        
        view.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
        
        
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellsToLoad.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let baseCell = (collectionView.dequeueReusableCell(withReuseIdentifier: cellsToLoad[indexPath.item].identifier, for: indexPath))
        
        guard let cell = baseCell as? BaseCollectionViewCell else { return baseCell }
        
        cell.baseModel = viewModel
        cell.selectedStruct = cellsToLoad[indexPath.item]
        
        return cell
    }
    
}
