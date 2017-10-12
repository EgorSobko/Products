//
//  ProductNetworkServiceTests.swift
//  ProductsApp
//
//  Created by Egor Sobko on 13.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Kit

class ProductNetworkServiceTests: QuickSpec {
  
  override func spec() {
    describe("ProductNetworkService") {
      
      let networkService = ProductsNetworkService()
      let firstName = "Leichte Slim Fit-Jeans in Sommerfarben"
      let firstPrice: Float = 16.99
      let firstThumbnail = "catalog/product/cache/1/image/400x/9df78eab33525d08d6e5fb8d27136e95/l/e/lesa3_178uh0006_titel2.jpg"
      
      beforeEach {
        MocksController.setupMocks()
      }
      
      it("should fetch, parse and map products") {
        let credentials = Credentials(id: "test", userToken: "test", storeId: 999)
        
        var itemsCount: Int!
        var page: Int!
        var pageCount: Int!
        var responseFirstName: String!
        var responseFirstPrice: Float!
        var responseFirstThumbnail: String!
        
        networkService.fetchProducts(with: credentials, pageOverride: 1) { result in
          switch result {
          case .success(let response):
            responseFirstName = response.products.first?.name!
            responseFirstPrice = response.products.first?.price!
            responseFirstThumbnail = response.products.first?.thumbnailPath!
            itemsCount = response.products.count
            page = response.page
            pageCount = response.pagesCount
            
          case .failure(_):
            fail("mocked response should succeed")
          }
        }
        
        expect(itemsCount).toEventually(equal(48))
        expect(page).toEventually(equal(1))
        expect(pageCount).toEventually(equal(366))
        expect(responseFirstName).toEventually(equal(firstName))
        expect(responseFirstPrice).toEventually(equal(firstPrice))
        expect(responseFirstThumbnail).toEventually(equal(firstThumbnail))
      }
    }
  }
}

