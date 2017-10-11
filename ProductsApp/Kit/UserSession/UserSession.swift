//
//  UserSession.swift
//  ProductsApp
//
//  Created by Egor Sobko on 11.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import KeychainAccess

final class UserSession {
  
  // MARK: - Properties
  let id: String
  let serviceLocator = ServiceLocator()
  var credentials: Credentials? {
    return credentialStorage.credentials
  }
  
  // MARK: - Private properties
  private let credentialStorage: CredentialsStorageInterface
  
  // MARK: - Init
  init(id: String) {
    self.id = id
    let keychain = Keychain(service: Constants.Session.identifier)
    self.credentialStorage = CredentialsStorage(credentialsId: id, repository: keychain)
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
  }
  
  func close() {
    
  }
}
