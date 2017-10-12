//
//  HUDWrapper.swift
//  ProductsApp
//
//  Created by Egor Sobko on 12.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import SVProgressHUD

class HUDWrapper {
  
  class func customize() {
    SVProgressHUD.setMinimumDismissTimeInterval(1)
    SVProgressHUD.setDefaultStyle(.custom)
    SVProgressHUD.setForegroundColor(UIColor.white)
    SVProgressHUD.setBackgroundColor(UIColor(white: 0, alpha: 0.5))
  }
  
  class func showSuccess(with status: String) {
    SVProgressHUD.showSuccess(withStatus: status)
  }
  
  class func show(in view: UIView? = nil, withStatus status: String? = nil, shouldBlock: Bool = false) {
    if shouldBlock {
      SVProgressHUD.setDefaultMaskType(.gradient)
    }
    SVProgressHUD.show()
  }
  
  class func dismiss() {
    SVProgressHUD.dismiss()
    SVProgressHUD.setDefaultMaskType(.none)
  }
  
  class func dismiss(with error: String?) {
    if let error = error {
      SVProgressHUD.showError(withStatus: error)
    } else {
      HUDWrapper.dismiss()
    }
  }
  
  class func showError(with status: String) {
    SVProgressHUD.showError(withStatus: status)
  }
}
