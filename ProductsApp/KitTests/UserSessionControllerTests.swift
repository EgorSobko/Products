//
//  UserSessionControllerTests.swift
//  ProductsApp
//
//  Created by Egor Sobko on 13.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Kit

class UserSessionControllerTests: QuickSpec {
  
  override func spec() {
    describe("UserSessionController") {
      
      let networkService = UserSessionControllerNetworkService()
      var userDefaults: UserDefaults!
      var userSessionController: UserSessionController!
      
      beforeEach {
        MocksController.setupMocks()
        userDefaults = UserDefaults(suiteName: "UserSessionControllerTests")!
      }
      
      afterEach {
        userDefaults.removePersistentDomain(forName: "UserSessionControllerTests")
      }
      
      it("should init") {
        userSessionController = UserSessionController(userDefaults: userDefaults, networkService: networkService)
        
        expect(userSessionController).notTo(beNil())
      }
      
      it("should start anonymouse session") {
        userSessionController.startAnonymousSession(completion: nil)
        
        expect(userSessionController.userSession).toEventuallyNot(beNil())
        expect(userSessionController.userSession.credentials).toEventuallyNot(beNil())
      }
      
      it("should restore") {
        userSessionController = UserSessionController(userDefaults: userDefaults, networkService: networkService)
        userSessionController.startAnonymousSession(completion: nil)
        
        let newUserSessionController = UserSessionController(userDefaults: userDefaults, networkService: networkService)
        expect(newUserSessionController.canRestorePreviousSession).toEventually(equal(true))
        expect(newUserSessionController.userSession).toEventually(beNil())
        
        newUserSessionController.restorePreviousSession(completion: nil)
        expect(newUserSessionController.userSession).toEventuallyNot(beNil())
        expect(newUserSessionController.userSession.credentials).toEventuallyNot(beNil())
      }
    }
  }
}
