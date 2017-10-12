//
//  MainRouter.swift
//  ProductsApp
//
//  Created by Egor Sobko on 13.10.17.
//  Copyright © 2017 Egor Sobko. All rights reserved.
//

import Foundation
import Kit

class MainRouter {
  
  // MARK: - Private properties
  private let userSessionController: UserSessionController
  private weak var window: UIWindow?
  private weak var emptyViewController: UIViewController?
  
  // MARK: - Init
  init(userSessionController: UserSessionController) {
    self.userSessionController = userSessionController
  }
  
  // MARK: - Methods
  func execute(in window: UIWindow) {
    let emptyViewController = UIViewController()
    emptyViewController.view.backgroundColor = .white
    window.rootViewController = emptyViewController
    window.makeKeyAndVisible()
    self.window = window
    self.emptyViewController = emptyViewController
    
    HUDWrapper.show()
    weak var weakSelf = self
    if userSessionController.canRestorePreviousSession {
      userSessionController.restorePreviousSession(completion: weakSelf?.handleSessionStart(with:))
    } else {
      userSessionController.startAnonymousSession(completion: weakSelf?.handleSessionStart(with:))
    }
  }
  
  // MARK: - Private methods
  private func handleSessionStart(with result: Result<Void>) {
    guard let window = window, let emptyViewController = emptyViewController else { return }
    
    switch result {
    case .success():
      showMainModule(in: window, emptyViewController: emptyViewController)
      HUDWrapper.dismiss()
      
    case .failure(let error):
      HUDWrapper.dismiss(with: error.localizedDescription)
    }
  }
  
  private func showMainModule(in window: UIWindow, emptyViewController: UIViewController) {
    guard let windowRootViewController = window.rootViewController else { return }
    
    let controller: MainViewController = UIViewController.makeViewController(from: .main)
    let model = MainModel(userSession: userSessionController.userSession)
    controller.setModel(model)
    
    UIView.transition(
      from: windowRootViewController.view,
      to: controller.view,
      duration: 0.25,
      options: .transitionCrossDissolve,
      completion: { completion in
        window.rootViewController = controller
    })
  }
}
