//
//  ProductsNetworkService.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation

public typealias ProductsCompletion = (Result<ProductResponse>) -> Void

public protocol ProductsNetworkServiceInterface {
  
  func fetchProducts(with credentials: Credentials, pageOverride: Int, completion: ProductsCompletion?)
}

class ProductsNetworkService: ProductsNetworkServiceInterface {
  
  // MARK: - Private properties
  private let apiClient = APIClient()
  
  // MARK: - Methods
  public func fetchProducts(with credentials: Credentials, pageOverride: Int, completion: ProductsCompletion?) {
    let request = GetProductsRequest(credentials: credentials, pageOverride: pageOverride)
    apiClient.performRequest(request).handleResult(completion: completion)
  }
}
