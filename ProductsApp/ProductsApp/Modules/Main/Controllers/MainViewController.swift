//
//  MainViewController.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import UIKit

private let kInterItemGap: CGFloat = 6

class MainViewController: UIViewController {
  
  // MARK: - Privtae outlets
  @IBOutlet private weak var collectionView: UICollectionView! {
    didSet {
      collectionView.dataSource = self
      collectionView.delegate = self
    }
  }
  
  // MARK: - Private properties
  private var router: Any?
  fileprivate var model: MainModelInterface!
  
  // MARK: - Dependencies
  func setRouter(_ router: Any) {
    self.router = router
  }
  
  func setModel(_ model: MainModelInterface) {
    self.model = model
    self.model.startActivityHandler = {
      HUDWrapper.show()
    }
    self.model.endActivityHandler = { error in
      HUDWrapper.dismiss(with: error?.localizedDescription)
    }
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  // MARK: - Privtae methods
  private func setup() {
    collectionView.registerReusableCell(cellType: ProductCollectionCell.self)
  }
}

extension MainViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return model.itemsCount
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: ProductCollectionCell = collectionView.dequeueReusableCell(indexPath)
    cell.configure(with: model[indexPath.row])
    
    return cell
  }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (collectionView.frame.width / 2) - (kInterItemGap / 2)
    let height: CGFloat = 120
    
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return kInterItemGap
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return kInterItemGap
  }
}
