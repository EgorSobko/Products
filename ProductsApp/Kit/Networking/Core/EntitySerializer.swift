//
//  EntitySerializer.swift
//  WeaterApp
//
//  Created by Egor Sobko on 03.09.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

struct EntitySerializer<T: Mappable> {
  
  // MARK: - Object serialization
  static func objectSerializer(with keyPath: String? = nil) -> DataResponseSerializer<T> {
    return DataRequest.ObjectMapperSerializer(keyPath)
  }
  
  // MARK: - Collection serialization
  static func collectionSerializer(with keyPath: String? = nil) -> DataResponseSerializer<[T]> {
    return DataRequest.ObjectMapperArraySerializer(keyPath)
  }
}
