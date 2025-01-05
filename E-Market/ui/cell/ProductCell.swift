//
//  ProductCell.swift
//  E-Market
//
//  Created by gizem on 5.01.2025.
//

import Foundation
import UIKit

class ProductCell: UICollectionViewCell {
    private let productImageView = UIImageView()
    private let priceLabel = UILabel()
    private let titleLabel = UILabel()
    private let addToCartButton = UIButton()
    private let favoriteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(productImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Verdana", size: 14)
        titleLabel.textColor = .black
        addSubview(titleLabel)
        titleLabel.numberOfLines = 0 
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont(name: "Verdana", size: 14)
        priceLabel.textColor = .primary
        priceLabel.numberOfLines = 1
        addSubview(priceLabel)
        
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.setTitle("Add to Cart", for: .normal)
        addToCartButton.titleLabel?.font = UIFont(name: "Verdana", size: 16)
        addToCartButton.backgroundColor = Colors.primary
        addSubview(addToCartButton)
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.setImage(UIImage(named: "Star2"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "Star3"), for: .selected)
        
        favoriteButton.tintColor = .yellow
        addSubview(favoriteButton)
        
        layer.borderColor = Colors.secondary.cgColor
        layer.borderWidth = 1.0
        
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            productImageView.heightAnchor.constraint(equalToConstant: 150),
            
            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 15),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
         //   addToCartButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            addToCartButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            addToCartButton.heightAnchor.constraint(equalToConstant: 36),
            
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configure(with product: Product) {
        if let imageURL = URL(string: product.image) {
                  productImageView.loadImage(from: imageURL)
              } else {
                  productImageView.image = nil
                  productImageView.backgroundColor = Colors.placeholder 
              }
        titleLabel.text = product.name
        priceLabel.text = "$\(product.price)"
    }
    
    static func cellHeight(for product: Product) -> CGFloat {
        let imageHeight: CGFloat = 150
        let padding: CGFloat = 10
        let buttonHeight: CGFloat = 36
        let titleLabelHeight = product.name.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 2 * padding, font: UIFont(name: "Verdana", size: 14)!)
        let priceLabelHeight: CGFloat = 17 // Assuming a constant price height->can be adjusted

        return imageHeight + padding * 3 + priceLabelHeight + titleLabelHeight + buttonHeight
    }
}
