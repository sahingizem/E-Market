//
//  CartController.swift
//  E-Market
//
//  Created by gizem on 5.01.2025.
//

import Foundation
import UIKit

class CartController: UIViewController, UICollectionViewDataSource {
    
    private let viewModel = CartViewModel()
    
    private let topView = UIView()
    private let titleLabel = UILabel()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let totalLabel = UILabel()
    private let priceSumLabel = UILabel()
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Complete", for: .normal)
        button.titleLabel?.font = UIFont(name: "Verdana-Bold", size: 18)
        button.backgroundColor = Colors.primary
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadCartItems()
        
        setupUI()
        collectionView.dataSource = self
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: "CartCell")
        print("Cart items: \(CoreDataManager.shared.cartItems)")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        completeButton.addTarget(self, action: #selector(didPressCompleteButton), for: .touchUpInside)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = UIScreen.main.bounds.width - 32
            layout.itemSize = CGSize(width: width, height: 100)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleCartUpdate), name: .cartUpdated, object: nil)
        
    }
    
    
    @objc private func didPressCompleteButton() {
        let alertController = UIAlertController(title: "Order Information", message: "We cannot place your order at the moment, but you will be able to place your desired order in the future. We are updating.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadCartItems()

        collectionView.reloadData()
        updateTotalPrice()
        
    }
    
    
    private func setupUI() {
        
        view.backgroundColor = .white
        collectionView.backgroundColor = .white

        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = Colors.primary
        view.addSubview(topView)
        
        topView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Verdana-Bold", size: 24)
        titleLabel.text = "Cart"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.text = "Total: "
        totalLabel.font = UIFont(name: "Verdana", size: 18)
        totalLabel.textColor = Colors.primary
        view.addSubview(totalLabel)
        
        priceSumLabel.translatesAutoresizingMaskIntoConstraints = false
        priceSumLabel.text = "0.00 ₺"
        priceSumLabel.font = UIFont(name: "Verdana-Bold", size: 18)
        priceSumLabel.textColor = .black
        priceSumLabel.textAlignment = .left
        view.addSubview(priceSumLabel)
        
        view.addSubview(completeButton)

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
            topView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            totalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            totalLabel.bottomAnchor.constraint(equalTo: priceSumLabel.topAnchor),
            
            priceSumLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            priceSumLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -17)
        ])
                
        NSLayoutConstraint.activate([
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            completeButton.widthAnchor.constraint(equalToConstant: 182),
            completeButton.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        
    }
    
    @objc private func handleCartUpdate() {
            collectionView.reloadData()
            updateTotalPrice()
        }
    
    private func updateTotalPrice() {
        let totalPrice = viewModel.calculateTotalPrice()
               priceSumLabel.text = "\(totalPrice) ₺"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath)
        let productItem = CoreDataManager.shared.cartItems[indexPath.row]
        cell.textLabel?.text = productItem.product.name
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CoreDataManager.shared.cartItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCell", for: indexPath) as! CartCell
           let cartItem = viewModel.cartItems[indexPath.item]
           cell.configure(with: cartItem)
           cell.quantityChanged = { [weak self] quantity in
               if quantity == 0 {
                   self?.viewModel.removeCartItem(at: indexPath.item)
               } else {
                   self?.viewModel.updateCartItemQuantity(at: indexPath.item, quantity: quantity)
               }
               self?.updateTotalPrice()
           }
           return cell
       }
}
