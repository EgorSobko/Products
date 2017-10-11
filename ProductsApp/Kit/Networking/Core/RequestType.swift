//
//  RequestType.swift
//  WeaterApp
//
//  Created by Egor Sobko on 03.09.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import Alamofire

typealias Method = Alamofire.Method

enum URLPrefix: String {
  
  case http = "http://"
  case https = "https://"
}

enum URLPostfix: String {
  
  case version5 = "v5/"
}

protocol RequestType {
  
  associatedtype ResponseObject
  
  var baseURL: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var urlPrefix: URLPrefix { get }
  var urlPostfix: URLPostfix { get }
  var parameters: [String: Any] { get }
  var headers: [String: String] { get }
  var encoding: ParameterEncoding { get }
  var responseSerializer: DataResponseSerializer<ResponseObject> { get }
}

extension RequestType {
  
  public var baseURL: String {
    return APIEndpoints.baseURL
  }
  
  public var urlPrefix: URLPrefix {
    return .https
  }
  
  public var urlPostfix: URLPostfix {
    return .version5
  }
  
  public var method: HTTPMethod {
    return .get
  }
  
  public var parameters: [String: Any] {
    return [:]
  }
  
  public var headers: [String: String] {
    return [:]
  }
  
  public var encoding: ParameterEncoding {
    return URLEncoding.default
  }
  
  public var responseSerializer: DataResponseSerializer<Any> {
    return DataRequest.jsonResponseSerializer()
  }
}
