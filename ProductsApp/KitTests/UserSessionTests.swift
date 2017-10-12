//
//  UserSessionTests.swift
//  ProductsApp
//
//  Created by Egor Sobko on 13.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Kit

class UserSessionTests: QuickSpec {
  
  override func spec() {
    describe("UserSession") {
      
      var userSession: UserSession!
      
      beforeEach {
        userSession = UserSession(id: "test", repository: MockedRepository())
      }
      let credentials = Credentials(id: "fff", userToken: "testtest", storeId: 999)

      it("anonymous session mustn't have credentials") {
        expect(userSession.credentials).to(beNil())
      }
      
      it("when initiated with credential, should persist them") {
        let newUserSession = UserSession(credentials: credentials)
        
        expect(newUserSession.credentials).notTo(beNil())
        expect(newUserSession.credentials?.id).to(equal("fff"))
        expect(newUserSession.credentials?.userToken).to(equal("testtest"))
        expect(newUserSession.credentials?.storeId).to(equal(999))
      }
      
      it("should open with services and api context") {
        userSession.open(with: MockedAPIContextProvider())
        
        let productsNetworkService: ProductsNetworkServiceInterface = userSession.serviceLocator.getService()
        expect(productsNetworkService).notTo(beNil())
        let apiContext: APIContextProvider = userSession.serviceLocator.getService()
        expect(apiContext).notTo(beNil())
        expect(apiContext.imageURLDomen).to(equal("testDomen"))
      }
    }
  }
}

class MockedAPIContextProvider: APIContextProvider {
  
  var imageURLDomen: String? {
    return "testDomen"
  }
}
