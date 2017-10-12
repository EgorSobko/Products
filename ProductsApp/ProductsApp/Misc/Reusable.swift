//
//  Reusable.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import UIKit

protocol Reusable: class {
  
  static var reuseIdentifier: String { get }
  
}
extension Reusable {
  
  static var reuseIdentifier: String {
    return String(describing: self)
  }
  
}

protocol NibReusable: Reusable, NibLoadable {}
protocol NibLoadable: class {
  
  static var nib: UINib { get }
  
}
extension NibLoadable {
  
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
  }
  
}

protocol GenericNibReusable: NibReusable {
  
  associatedtype CellModel
  
  func configure(with cellModel: CellModel)
  
}
