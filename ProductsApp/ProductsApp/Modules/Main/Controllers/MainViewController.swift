//
//  MainViewController.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import UIKit
import Nuke

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
  fileprivate var model: MainModelInterface!
  
  // MARK: - Dependencies
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
    fetchProducts()
  }
  
  // MARK: - Private methods
  private func setup() {
    collectionView.registerReusableCell(cellType: ProductCollectionCell.self)
    let preheater = Preheater(manager: Manager.shared, scheduler: OperationQueueScheduler(maxConcurrentOperationCount: 4))
    let prefetcher = MainViewPrefetcher(dataProvider: model, preheater: preheater)
    collectionView.prefetchDataSource = prefetcher
  }
  
  fileprivate func fetchProducts() {
    model.fetchProducts { [weak self] result in
      guard let strongSelf = self else { return }
      
      if case .success(let newObjectsCount) = result {
        let collectionView = strongSelf.collectionView!
        let currentObjectsCount = collectionView.numberOfItems(inSection: 0)
        let indexPaths = IndexPath.indexPaths(forCurrentObjectsCount: currentObjectsCount, newObjectsCount: newObjectsCount)
        collectionView.performBatchUpdates({
          collectionView.insertItems(at: indexPaths)
        }, completion: nil)
      }
    }
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
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if (scrollView.contentOffset.y + scrollView.frame.height) / scrollView.contentSize.height > 0.9 {
      fetchProducts()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (collectionView.frame.width / 2) - (kInterItemGap / 2)
    let height: CGFloat = 275
    
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return kInterItemGap
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return kInterItemGap
  }
}
