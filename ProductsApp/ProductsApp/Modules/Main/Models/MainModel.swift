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
  
  var itemsCount: Int { get }
  subscript(index: Int) -> ProductCollectionCellModelInterface { get }
  
  func fetchProducts(completion: ProductsModelCompletion?)
}

class MainModel: BaseModel, MainModelInterface {
  
  // MARK: - Properties
  var itemsCount: Int {
    return products.count
  }
  subscript(index: Int) -> ProductCollectionCellModelInterface {
    return viewProducts[index]
  }
  
  // MARK: - Private properties
  private let paginationContext = PaginationContext(pageSize: kProductsPageSize)
  private let userSession: UserSession
  private var networkService: ProductsNetworkServiceInterface {
    return userSession.serviceLocator.getService()
  }
  private var apiContext: APIContextProvider {
    return userSession.serviceLocator.getService()
  }
  private var products: [Product] = []
  private var viewProducts: [ProductCollectionCellModel] = []
  
  // MARK: - Init
  init(userSession: UserSession) {
    self.userSession = userSession
  }
  
  // MARK: - Methods
  func fetchProducts(completion: ProductsModelCompletion?) {
    guard
      let credentials = userSession.credentials,
      let imageDomen = apiContext.imageURLDomen,
      paginationContext.hasMoreData && !paginationContext.isFetching else { return }
    
    startActivity()
    paginationContext.toggleFetch()
    networkService.fetchProducts(with: credentials, pageOverride: 1) { [weak self] result in
      guard let strongSelf = self else { return }
      strongSelf.paginationContext.toggleFetch()

      switch result {
      case .success(let response):
        strongSelf.paginationContext.setHasMoreData(to: response.page < response.pagesCount)
        strongSelf.paginationContext.incrementPage()
        strongSelf.products.append(contentsOf: response.products)
        strongSelf.viewProducts.append(contentsOf: response.products.map({ ProductCollectionCellModel(product: $0, imageDomen: imageDomen) }))
        completion?(.success(response.products.count))
        
      case .failure(let error):
        strongSelf.endActivity(with: error)
        completion?(.failure(error))
      }
    }
  }
  
}
