//
//  CredentialStorage.swift
//  ProductsApp
//
//  Created by Egor Sobko on 11.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import KeychainAccess
import Foundation

protocol RepositoryInterface: class {
  
  subscript(data key: String) -> Data? { get set }
}

protocol CredentialsStorageInterface: class {
  
  var credentials: Credentials? { get set }
  
  func clean()
}

extension Keychain: RepositoryInterface {}

final class CredentialsStorage: CredentialsStorageInterface {
  
  // MARK: - Properties
  var credentials: Credentials? {
    get {
      if _credentials == nil {
        fulfillCredentials()
      }
      
      return _credentials
    }
    set {
      if newValue != nil {
        _credentials = newValue
        updateRepository()
      }
    }
  }
  
  // MARK: - Private Properties
  private let credentialsId: String
  private let repository: RepositoryInterface
  private var _credentials: Credentials?
  
  // MARK: - Init
  init(credentialsId: String, repository: RepositoryInterface) {
    self.credentialsId = credentialsId
    self.repository = repository
  }
  
  // MARK: - Methods
  func clean() {
    repository[data: credentialsId] = nil
  }
  
  // MARK: - Private methods
  private func updateRepository() {
    repository[data: credentialsId] = _credentials.flatMap({NSKeyedArchiver.archivedData(withRootObject: $0.representation)})
  }
  
  private func fulfillCredentials() {
    if
      let representationData = repository[data: credentialsId],
      let representation = NSKeyedUnarchiver.unarchiveObject(with: representationData) as? [String: Any]
    {
      _credentials = Credentials(representation: representation)
    }
  }
}
