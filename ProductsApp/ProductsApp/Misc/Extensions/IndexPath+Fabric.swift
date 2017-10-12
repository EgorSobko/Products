//
//  IndexPath+Fabric.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import UIKit

extension IndexPath {
  
  static func indexPaths(forCurrentObjectsCount currentObjects: Int, newObjectsCount: Int, section: Int = 0) -> [IndexPath] {
    if newObjectsCount == 0 {
      return []
    } else {
      var indexPaths = [IndexPath]()
      
      for index in 0..<newObjectsCount {
        let indexPath = IndexPath(row: index + currentObjects, section: section)
        indexPaths.append(indexPath)
      }
      
      return indexPaths
    }
  }
}
