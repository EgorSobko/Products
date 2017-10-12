//
//  UserSession.swift
//  ProductsApp
//
//  Created by Egor Sobko on 11.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import KeychainAccess

public final class UserSession {
  
  // MARK: - Properties
  let id: String
  public let serviceLocator = ServiceLocator()
  public var credentials: Credentials? {
    return credentialStorage.credentials
  }
  
  // MARK: - Private properties
  private let credentialStorage: CredentialsStorageInterface
  
  // MARK: - Init
  init(id: String, repository: RepositoryInterface = Keychain(service: Constants.Session.identifier)) {
    self.id = id
    self.credentialStorage = CredentialsStorage(credentialsId: id, repository: repository)
  }
  
  convenience init(credentials: Credentials) {
    self.init(id: credentials.id)
    
    self.credentialStorage.credentials = credentials
  }
  
  // MARK: - Methods
  func open(with apiContext: APIContextProvider? = nil) {
    if let apiContext = apiContext {
      serviceLocator.registerService(apiContext)
    }
    let productsNetworkService: ProductsNetworkServiceInterface = ProductsNetworkService()
    serviceLocator.registerService(productsNetworkService)
  }
  
  func close() {
    //clean resources if needed
  }
}
