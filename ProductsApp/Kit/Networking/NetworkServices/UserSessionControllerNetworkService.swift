//
//  UserSessionControllerNetworkService.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import BoltsSwift

public typealias SignInAnonymouseCompletion = (Result<(user: AnonymousUser, apiContext: APIContextProvider)>) -> Void
public typealias APIContextCompletion = (Result<APIContextProvider>) -> Void

public protocol UserSessionControllerNetworkServiceInterface {
  
  func signInAnonymousUser(completion: SignInAnonymouseCompletion?)
  func getAPIContext(userToken: String, storeId: Int, completion: APIContextCompletion?)
}

public class UserSessionControllerNetworkService: UserSessionControllerNetworkServiceInterface {
  
  // MARK: - Private properties
  private let apiClient = APIClient()
  
  // MARK: - Init
  public init() {}
  
  // MARK: - Methods
  public func signInAnonymousUser(completion: SignInAnonymouseCompletion?) {
    let signInRequest = SignInAnonymousRequest()
    var anonymousUser: AnonymousUser!
    apiClient.performRequest(signInRequest)
      .continueOnSuccessWithTask { [weak self] anonymousUserResponse -> Task<AppAPIContext> in
        guard
          let strongSelf = self,
          let userToken = anonymousUserResponse.userToken else {
            return Task<AppAPIContext>.cancelledTask()
        }
        anonymousUser = anonymousUserResponse
        let request = GetAPIContextRequest(userToken: userToken, storeId: anonymousUserResponse.storeId)
        
        return strongSelf.apiClient.performRequest(request)
      }
      .continueWith { task in
        if let error = task.error {
          completion?(.failure(error))
        } else if let apiContext = task.result {
          completion?(.success(anonymousUser, apiContext))
        } else {
          completion?(.failure(InternalError.unknownError))
        }
    }
  }
  
  public func getAPIContext(userToken: String, storeId: Int, completion: APIContextCompletion?) {
    let request = GetAPIContextRequest(userToken: userToken, storeId: storeId)
    apiClient.performRequest(request).handleResult(completion: completion)
  }
}
