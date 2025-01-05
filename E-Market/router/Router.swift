//
//  Router.swift
//  E-Market
//
//  Created by gizem on 5.01.2025.
//

import Foundation
import UIKit

class Router {
    static let shared = Router()
    
    private init() {}
    
    func setRootViewController(window: UIWindow?, controller: UIViewController) {
        guard let window = window else { return }
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
    
    func navigateToProductList(from controller: UIViewController) {
        let productListController = ProductListController()
        controller.navigationController?.pushViewController(productListController, animated: true)
    }
}
