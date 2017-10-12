//
//  MainModel.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import Kit

private let kProductsPageSize = 48

typealias ProductsModelCompletion = (Result<Int>) -> Void

protocol MainModelInterface: BaseModelInterface {
  
  func fetchProducts(completion: ProductsModelCompletion?)
}

class MainModel: BaseModel, MainModelInterface {
  
  // MARK: - Private properties
  private let paginationContext = PaginationContext(pageSize: kProductsPageSize)
  
  // MARK: - Methods
  func fetchProducts(completion: ProductsModelCompletion?) {
    guard paginationContext.hasMoreData && !paginationContext.isFetching else { return }
    
    startActivity()
  }
  
}
