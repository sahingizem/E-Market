//
//  TabbarController.swift
//  E-Market
//
//  Created by gizem on 5.01.2025.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = .black
        tabBar.isTranslucent = false
        view.backgroundColor = .white
        tabBar.unselectedItemTintColor = .black
        tabBar.tintColor = .black  

        let productList = ProductListController()
        let cart = CartController()
        let favourites = FavouritesController()
        let account = AccountController()
        
        let productListNav = UINavigationController(rootViewController: productList)
               let cartNav = UINavigationController(rootViewController: cart)
               let favouritesNav = UINavigationController(rootViewController: favourites)
               let accountNav = UINavigationController(rootViewController: account)
               
        
        productList.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home"), selectedImage: UIImage(named: "first_icon_selected"))
        cart.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Cart"), selectedImage: UIImage(named: "second_icon_selected"))
        favourites.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Favourites"), selectedImage: UIImage(named: "third_icon_selected"))
        account.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Account"), selectedImage: UIImage(named: "fourth_icon_selected"))
        
        self.viewControllers = [productListNav, cartNav, favouritesNav, accountNav]
    }
}
