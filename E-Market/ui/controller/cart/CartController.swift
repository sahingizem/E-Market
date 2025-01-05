//
//  CartController.swift
//  E-Market
//
//  Created by gizem on 5.01.2025.
//

import Foundation
import UIKit

class CartController: UIViewController {
    
    private let topView = UIView()
    private let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = Colors.primary
        view.addSubview(topView)
        
        topView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Verdana-Bold", size: 24)
        titleLabel.text = "Cart"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 51),
            titleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
