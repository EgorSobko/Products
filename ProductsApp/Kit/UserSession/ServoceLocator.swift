//
//  ServoceLocator.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation

public final class ServiceLocator {
  
  private var registry: [String: Any] = [:]
  
  func registerService<T>(_ service: T) {
    let key = "\(T.self)"
    registry[key] = service
  }
  
  public func getService<T>() -> T {
    let key = "\(T.self)"
    return registry[key] as! T
  }
}
