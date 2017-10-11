//
//  UserSessionControllerNetworkService.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation

typealias SignInAnonymouseCompletion = (Result<(AnonymousUser, APIContextProvider)>) -> Void

protocol UserSessionControllerNetworkServiceInterface {
  
  func signInAnonymousUser(completion: SignInAnonymouseCompletion?)
}

class UserSessionControllerNetworkService: UserSessionControllerNetworkServiceInterface {
  
  // MARK: - Private properties
  private let apiClient = APIClient()
  
  // MARK: - Methods
  func signInAnonymousUser(completion: SignInAnonymouseCompletion?) {
    
  }
}
