//
//  CartCell.swift
//  E-Market
//
//  Created by gizem on 6.01.2025.
//

import Foundation
import UIKit

class CartCell: UICollectionViewCell {
    
    private let productLabel = UILabel()
    private let priceLabel = UILabel()
    private let minusButton = UIButton()
    private let plusButton = UIButton()
    private let itemNumberLabel = UILabel()
    
    var quantityChanged: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        productLabel.translatesAutoresizingMaskIntoConstraints = false
        productLabel.font = UIFont(name: "Verdana", size: 16)
        productLabel.textColor = .darkGray
        productLabel.numberOfLines = 0
        productLabel.lineBreakMode = .byWordWrapping
        contentView.addSubview(productLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont(name: "Verdana", size: 16)
        priceLabel.textColor = .primary
        priceLabel.numberOfLines = 0
        priceLabel.lineBreakMode = .byWordWrapping
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            productLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            productLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            productLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            priceLabel.topAnchor.constraint(equalTo: productLabel.bottomAnchor, constant: 0),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
        ])
        
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.setTitle("-", for: .normal)
        minusButton.setTitleColor(.black, for: .normal)
        minusButton.backgroundColor = .secondary
        minusButton.addTarget(self, action: #selector(decreaseItemNumber), for: .touchUpInside)
        contentView.addSubview(minusButton)
        
        itemNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNumberLabel.font = UIFont(name: "Verdana", size: 16)
        itemNumberLabel.textColor = .white
        itemNumberLabel.textAlignment = .center
        itemNumberLabel.backgroundColor = Colors.primary
        itemNumberLabel.text = "1"
        contentView.addSubview(itemNumberLabel)
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(.black, for: .normal)
        plusButton.backgroundColor = .secondary
        plusButton.addTarget(self, action: #selector(increaseItemNumber), for: .touchUpInside)
        contentView.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            minusButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            minusButton.widthAnchor.constraint(equalToConstant: 50),
            minusButton.heightAnchor.constraint(equalToConstant: 50),
            
            itemNumberLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 0),
            itemNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            itemNumberLabel.widthAnchor.constraint(equalToConstant: 50),
            itemNumberLabel.heightAnchor.constraint(equalToConstant: 50),
            
            plusButton.leadingAnchor.constraint(equalTo: itemNumberLabel.trailingAnchor, constant: 0),
            plusButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            plusButton.widthAnchor.constraint(equalToConstant: 50),
            plusButton.heightAnchor.constraint(equalToConstant: 50),
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16) 
        ])
    }
    
    
    func configure(with cartItem: CartItem) {
        productLabel.text = cartItem.product.name
        priceLabel.text = "$\(cartItem.product.price)"
        itemNumberLabel.text = "\(cartItem.quantity)"
    }
    
    @objc private func decreaseItemNumber() {
        if let currentValue = Int(itemNumberLabel.text ?? "0"), currentValue > 0 {
            let newValue = currentValue - 1
            itemNumberLabel.text = "\(newValue)"
            quantityChanged?(newValue)
        }
    }
    @objc private func increaseItemNumber() {
        if let currentValue = Int(itemNumberLabel.text ?? "0") {
            let newValue = currentValue + 1
            itemNumberLabel.text = "\(newValue)"
            quantityChanged?(newValue)
        }
    }
}


