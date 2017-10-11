//
//  SignInAnonymousRequest.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import Alamofire

class SignInAnonymousRequest: RequestType {
  
  var path: String {
    return Constants.APIEndpoints.anonuser + "?\(appToken)"
  }
  
  var method: HTTPMethod {
    return .post
  }
  
  var parameters: [String: Any] {
    var tempParameters: [String: Any] = [:]
    tempParameters["device_locale"] = deviceLocale
    tempParameters["app_instance_id"] = uuidString
    
    return tempParameters
  }
  
  var encoding: ParameterEncoding {
    return JSONEncoding.default
  }
  
  var responseSerializer: DataResponseSerializer<AnonymousUser> {
    return EntitySerializer.objectSerializer()
  }
  
  private let appToken: String
  private let deviceLocale: String?
  private let uuidString: String?

  init(appToken: String = Constants.API.token,
       deviceLocale: String? = "en",
       uuidString: String? = UIDevice.current.identifierForVendor?.uuidString) {
    self.appToken = appToken
    self.deviceLocale = deviceLocale
    self.uuidString = uuidString
  }
}
