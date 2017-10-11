//
//  InternalError.swift
//  WeaterApp
//
//  Created by Egor Sobko on 03.09.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation

public enum InternalErrorCode: String {
  
  case invalidPath
  case deserialization
  case invalidResponse
  case locationDenied
  case noLocations
}

public struct InternalError: Error {
  
  // MARK: - Properties
  public static var invalidPathError: InternalError {
    return InternalError(code: .invalidPath)
  }
  public static var deserializationError: InternalError {
    return InternalError(code: .deserialization)
  }
  public static var invalidResponseError: InternalError {
    return InternalError(code: .invalidResponse)
  }
  public static var locationDeniedError: InternalError {
    return InternalError(code: .locationDenied)
  }
  public static var locationUpdateError: InternalError {
    return InternalError(code: .noLocations)
  }
  
  public let code: InternalErrorCode
  public let localizedDescription: String?
  
  // MARK: - Init
  public init(code: InternalErrorCode, localizedDescription: String? = nil) {
    self.code = code
    self.localizedDescription = localizedDescription ?? code.rawValue
  }
}
