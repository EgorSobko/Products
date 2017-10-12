//
//  MainViewController.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  // MARK: - Privtae outlets
  @IBOutlet private weak var collectionView: UICollectionView!
  
  // MARK: - Private properties
  private var router: Any?
  private var model: MainModelInterface!
  
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
}
