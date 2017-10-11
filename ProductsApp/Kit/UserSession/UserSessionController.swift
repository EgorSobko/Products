//
//  UserSessionController.swift
//  ProductsApp
//
//  Created by Egor Sobko on 11.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation

final class UserSessionController {
  
  // MARK: - Properties
  public private(set) var userSession: UserSession! {
    get {
      return _userSession
    }
    set {
      let oldValue = _userSession
      _userSession = newValue
      userSessionId = newValue?.id
      oldValue?.close()
    }
  }
  
  // MARK: - Private properties
  private let userDefaults: UserDefaults
  private var userSessionId: String? {
    get {
      return userDefaults.object(forKey: Constants.Session.identifier) as? String
    }
    set {
      userDefaults.set(newValue, forKey: Constants.Session.identifier)
      userDefaults.synchronize()
    }
  }
  private var _userSession: UserSession!
  
  // MARK: - Init
  public init(userDefaults: UserDefaults) {
    self.userDefaults = userDefaults
  }
  
  // MARK: - Methods
  public func startAnonymousSession(completion: VoidResultCompletion?) {
    assert(userSession == nil, "Can't open 2 sessions")

    
  }
  
  public func restorePreviousSession(completion: VoidResultCompletion?) {
    assert(userSession == nil, "Can't open 2 sessions")
    
    userSession = userSessionId.flatMap { UserSession(id: $0) }
    
  }
  
  public func canRestorePreviousSession() -> Bool {
    return userSessionId != nil
  }
}
