//
//  PaginationContext.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import UIKit

final public class PaginationContext {
  
  // MARK: - Properties
  public private(set) var page: Int
  public let pageSize: Int
  public private(set) var isFetching: Bool
  public private(set) var isInitiallyFetched: Bool
  public private(set) var hasMoreData: Bool
  
  // MARK: - Init
  public init(page: Int = 1, pageSize: Int) {
    self.page = page
    self.pageSize = pageSize
    self.isFetching = false
    self.isInitiallyFetched = false
    self.hasMoreData = true
  }
  
  // MARK: - Methods
  public func incrementPage() {
    guard hasMoreData else { return }
    
    page += 1
  }
  
  public func toggleFetch() {
    isFetching = !isFetching
  }
  
  public func triggerIsInitiallyFetched() {
    isInitiallyFetched = true
  }
  
  public func reset() {
    page = 1
    hasMoreData = true
  }
  
  public func setHasMoreData(to flag: Bool) {
    hasMoreData = flag
  }
}
