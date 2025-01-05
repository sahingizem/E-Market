//
//  ProductDetailController.swift
//  E-Market
//
//  Created by gizem on 5.01.2025.
//

import Foundation
import UIKit

class ProductDetailController: UIViewController {
    
    private let product: Product
    
    private let topView = UIView()
    private let titleLabel = UILabel()


    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
            view.addSubview(topView)
            topView.translatesAutoresizingMaskIntoConstraints = false
            topView.backgroundColor = Colors.primary
            
            topView.addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.font = UIFont(name: "Verdana-Bold", size: 24)
            titleLabel.text = "Product Details"
            titleLabel.textColor = .white
            titleLabel.textAlignment = .left
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 16),
                titleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
                titleLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -16),
                
                topView.topAnchor.constraint(equalTo: view.topAnchor),
                topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                topView.heightAnchor.constraint(equalToConstant: 100)
            ])        
        
        let label = UILabel()
        label.text = "Product: \(product.name)\nPrice: \(product.price)\nDescription: \(product.description)"
        label.numberOfLines = 0
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
