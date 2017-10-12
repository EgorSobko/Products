//
//  Result.swift
//  WeaterApp
//
//  Created by Egor Sobko on 03.09.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation

public typealias VoidResultCompletion = (Result<Void>) -> Void

public enum Result<T> {
  
  case success(T)
  case failure(Error)
}
