//
//  InternalError.swift
//  WeaterApp
//
//  Created by Egor Sobko on 03.09.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation

public enum InternalErrorCode: String {
  
  case unknown
  case invalidPath
}

public struct InternalError: Error {
  
  // MARK: - Properties
  public static var unknownError: InternalError {
    return InternalError(code: .unknown)
  }
  
  public let code: InternalErrorCode
  public let localizedDescription: String?
  
  // MARK: - Init
  public init(code: InternalErrorCode, localizedDescription: String? = nil) {
    self.code = code
    self.localizedDescription = localizedDescription ?? code.rawValue
  }
}
