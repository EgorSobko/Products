//
//  CredentialStorageTests.swift
//  ProductsApp
//
//  Created by Egor Sobko on 13.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Kit

class CredentialStorageTests: QuickSpec {
  
  override func spec() {
    describe("CredentialStorage") {
      
      let credentialsStorage = CredentialsStorage(credentialsId: "test", repository: MockedRepository())
      let credentials = Credentials(id: "fff", userToken: "testtest", storeId: 999)
      
      it("should store credentials when assigned") {
        credentialsStorage.credentials = credentials
        
        expect(credentialsStorage.credentials).notTo(beNil())
        expect(credentialsStorage.credentials?.id).to(equal("fff"))
        expect(credentialsStorage.credentials?.userToken).to(equal("testtest"))
        expect(credentialsStorage.credentials?.storeId).to(equal(999))
      }
      
      it("should clean credentials") {
        credentialsStorage.clean()
        
        expect(credentialsStorage.credentials).to(beNil())
      }
    }
  }
}

class MockedRepository: RepositoryInterface {
  
  subscript(data key: String) -> Data? {
    get {
      return storage[key]
    }
    set {
      storage[key] = newValue
    }
  }
  
  private var storage: [String: Data] = [:]
  
}
