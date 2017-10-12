//
//  MocksController.swift
//  ProductsApp
//
//  Created by Egor Sobko on 13.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import OHHTTPStubs

final class MocksController {
  
  class func setupMocks() {
    mock(mockingRequest: SignInAnonymousRequest(), withJSON: "SignInAnonymousMock.json")
    mock(mockingRequest: GetAPIContextRequest(userToken: "test", storeId: 999), withJSON: "GetAPIMock.json")
    mock(mockingRequest: GetProductsRequest(credentials: Credentials(id: "111", userToken: "111", storeId: 111), pageOverride: 1), withJSON: "GetProductsMock.json")
  }
  
  class func mock<T: RequestType>(mockingRequest: T, withJSON json: String) {
    stub(condition: { request in
      return request.url!.absoluteString.contains(APIClient().makeURLWithComponents(in: mockingRequest)!.absoluteString)
    }, response: { request in
      let stubPath = OHPathForFile(json, MocksController.self)
      
      return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
    })
  }
}
