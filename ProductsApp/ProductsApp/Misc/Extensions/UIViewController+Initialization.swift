//
//  UIViewController+Initialization.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import UIKit

extension UIViewController {
  
  class func makeViewController<T: UIViewController>(from storyboardType: Storyboard,
                                withIdentifier identifier: String = String(describing: T.self)) -> T {
    let storyboard = UIStoryboard(name: storyboardType.rawValue, bundle: nil)
    
    return storyboard.instantiateViewController(withIdentifier: identifier) as! T
  }
}
