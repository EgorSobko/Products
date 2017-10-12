//
//  ProductCollectionCell.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import UIKit
import Kit
import Nuke

protocol ProductCollectionCellModelInterface {
  
  var productImageURL: URL? { get }
  var productName: String? { get }
  var productPrice: String? { get }
}

struct ProductCollectionCellModel: ProductCollectionCellModelInterface {
  
  let productImageURL: URL?
  let productName: String?
  let productPrice: String?
  
  init(product: Product, imageDomen: String) {
    self.productImageURL =  product.thumbnailPath.flatMap { URL(string: imageDomen + $0) }
    self.productName = product.name
    self.productPrice = product.price.flatMap { String(describing: $0) }
  }
}

class ProductCollectionCell: UICollectionViewCell, NibReusable {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    imageView.image = nil
    nameLabel.text = nil
    priceLabel.text = nil
  }
  
  func configure(with cellModel: ProductCollectionCellModelInterface) {
    if let productImageUrl = cellModel.productImageURL {
      Manager.shared.loadImage(with: productImageUrl, into: imageView)
    }
    nameLabel.text = cellModel.productName
    priceLabel.text = cellModel.productPrice
  }
}
