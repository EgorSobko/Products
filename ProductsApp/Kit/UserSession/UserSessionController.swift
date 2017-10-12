//
//  UserSessionController.swift
//  ProductsApp
//
//  Created by Egor Sobko on 11.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation

public final class UserSessionController {
  
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
  public var canRestorePreviousSession: Bool {
    return userSessionId != nil
  }
  
  // MARK: - Private properties
  private let userDefaults: UserDefaults
  private let networkService: UserSessionControllerNetworkServiceInterface
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
  public init(userDefaults: UserDefaults, networkService: UserSessionControllerNetworkServiceInterface) {
    self.userDefaults = userDefaults
    self.networkService = networkService
  }
  
  // MARK: - Public methods
  public func startAnonymousSession(completion: VoidResultCompletion?) {
    assert(userSession == nil, "Can't open 2 sessions")

    networkService.signInAnonymousUser { [weak self] result in
      switch result {
      case .success(let response):
        self?.handleAnonymousResponse(response, completion: completion)
        
      case .failure(let error):
        completion?(.failure(error))
      }
    }
  }
  
  public func restorePreviousSession(completion: VoidResultCompletion?) {
    assert(self.userSession == nil, "Can't open 2 sessions")
    
    let userSession = userSessionId.flatMap { UserSession(id: $0) }
    guard let userToken = userSession?.credentials?.userToken, let storeId = userSession?.credentials?.storeId else {
      completion?(.failure(InternalError.unknownError))
      return
    }
    networkService.getAPIContext(userToken: userToken, storeId: storeId) { [weak self] result in
      switch result {
      case .success(let apiContext):
        self?.userSession = userSession
        self?.userSession.open(with: apiContext)
        completion?(.success())
        
      case .failure(let error):
        completion?(.failure(error))
      }
    }
    
  }
  
  // MARK: - Private methods
  private func handleAnonymousResponse(_ response: (user: AnonymousUser, apiContext: APIContextProvider), completion: VoidResultCompletion?) {
    guard let userToken = response.user.userToken else { return }
    
    let uuid = UUID().uuidString
    let credentials = Credentials(id: uuid, userToken: userToken, storeId: response.user.storeId)
    userSession = UserSession(credentials: credentials)
    userSession.open(with: response.apiContext)
    completion?(.success())
  }
}
