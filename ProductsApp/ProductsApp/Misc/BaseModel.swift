//
//  BaseModel.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation

protocol BaseModelInterface {
  
  var startActivityHandler: (() -> Void)? { get set }
  var endActivityHandler: ((Error?) -> Void)? { get set }
}

class BaseModel: BaseModelInterface {
  
  var startActivityHandler: (() -> Void)?
  var endActivityHandler: ((Error?) -> Void)?
  
  private var activityCounter: Int = 0
  
  func startActivity() {
    activityCounter += 1
    if activityCounter == 1 {
      startActivityHandler?()
    }
  }
  
  func endActivity(with error: Error? = nil) {
    activityCounter -= 1
    if activityCounter == 0 {
      endActivityHandler?(error)
    }
  }
}
