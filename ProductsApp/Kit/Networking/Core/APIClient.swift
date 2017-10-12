//
//  APIClient.swift
//  WeaterApp
//
//  Created by Egor Sobko on 03.09.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import BoltsSwift
import Alamofire

typealias RequestTask = Alamofire.Request

class APIClient {
  
  // MARK: - Methods
  func performRequest<T: RequestType>(_ request: T) -> Task<T.ResponseObject> {
    let source = TaskCompletionSource<T.ResponseObject>()
    guard let url = makeURLWithComponents(in: request) else {      
      source.set(error: InternalError(code: .invalidPath))
      
      return source.task
    }
    
    let apiRequest = Alamofire.request(
      url,
      method: request.method,
      parameters: request.parameters,
      encoding: request.encoding,
      headers: request.headers
    )
    
    apiRequest.validate(statusCode: 200..<300).response(responseSerializer: request.responseSerializer) { response in
      switch response.result {
      case .success(let result):
        source.set(result: result)
      case .failure(let error):
        source.set(error: error)
      }
    }
    
    return source.task
  }
  
  func makeURLWithComponents<T: RequestType>(in request: T) -> URL? {
    let urlString = request.urlPrefix.rawValue +
      request.baseURL +
      request.urlPostfix.rawValue +
      request.path
    
    return URL(string: urlString)
  }
}

extension Task {
  
  func handleResult<T>(completion: ((_ result: Result<T>) -> Void)?) {
    continueWith { task in
      if let error = task.error {
        completion?(.failure(error))
      } else {
        guard let result = task.result as? T else {
          fatalError("Wrong generic type")
        }
        
        completion?(.success(result))
      }
    }
  }
}
