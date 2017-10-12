//
//  MainViewPreheater.swift
//  ProductsApp
//
//  Created by Egor Sobko on 13.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import UIKit
import Nuke

protocol MainViewPrefetcherDataProvider {
  
  subscript(index: Int) -> ProductCollectionCellModelInterface { get }
}

class MainViewPrefetcher: NSObject, UICollectionViewDataSourcePrefetching {
  
  // MARK: - Private properties
  private let dataProvider: MainViewPrefetcherDataProvider
  private let preheater: Preheater
  
  // MARK: - Init
  init(dataProvider: MainViewPrefetcherDataProvider, preheater: Preheater) {
    self.dataProvider = dataProvider
    self.preheater = preheater
  }
  
  // MARK: - Methods
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    let requests = indexPaths.flatMap { dataProvider[$0.row].productImageURL.flatMap { Request(url: $0) } }
    preheater.startPreheating(with: requests)
  }
}
