//
//  ProductListController.swift
//  E-Market
//
//  Created by gizem on 5.01.2025.
//

import Foundation
import UIKit

class ProductListController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private var favoriteProducts = [Product]()
    
    private let collectionView: UICollectionView
    private let viewModel = ProductListViewModel()
    private let topView = UIView()
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let searchTextField = UITextField()
    private let filtersLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        hideBackButton()
    }

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }

    private func setupUI() {
        view.backgroundColor = .white

        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = Colors.primary
        view.addSubview(topView)

        topView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Verdana-Bold", size: 24)
        titleLabel.text = "E-Market"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left

        headerView.translatesAutoresizingMaskIntoConstraints = false  
        view.addSubview(headerView)

        headerView.addSubview(searchTextField)
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.placeholder = "Search"
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        searchTextField.backgroundColor = .white
        searchTextField.font = UIFont(name: "Verdana", size: 18)
        searchTextField.textColor = .systemGray
        searchTextField.borderStyle = .roundedRect
        searchTextField.leftView = UIImageView(image: UIImage(named: "Search"))
        searchTextField.leftViewMode = .always
        searchTextField.layer.cornerRadius = 8

        headerView.addSubview(filtersLabel)
        filtersLabel.translatesAutoresizingMaskIntoConstraints = false
        filtersLabel.text = "Filters:"
        filtersLabel.font = UIFont(name: "Verdana", size: 18)
        filtersLabel.textColor = .black

        let selectFilterButton = UIButton()
        selectFilterButton.isUserInteractionEnabled = true
        selectFilterButton.translatesAutoresizingMaskIntoConstraints = false
        selectFilterButton.setTitle("Select Filter", for: .normal)
        selectFilterButton.setTitleColor(.black, for: .normal)
        selectFilterButton.titleLabel?.font = UIFont(name: "Verdana", size: 14)
        selectFilterButton.backgroundColor = Colors.secondary
        selectFilterButton.addTarget(self, action: #selector(selectFilterButtonTapped), for: .touchUpInside)
        headerView.addSubview(selectFilterButton)

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 100),

            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 51),
            titleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -16),

            headerView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 128),

            searchTextField.widthAnchor.constraint(equalToConstant: 360),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            searchTextField.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 14),
            searchTextField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),

            filtersLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 16),
            filtersLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),

            selectFilterButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 16),
            selectFilterButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -13),
            selectFilterButton.heightAnchor.constraint(equalToConstant: 36),
            selectFilterButton.widthAnchor.constraint(equalToConstant: 158),

            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
    }

    @objc private func selectFilterButtonTapped() {
        print("pressed")
        let filterController = FilterController()
            navigationController?.pushViewController(filterController, animated: true)
        }

    private func loadData() {
        viewModel.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print("Error loading products: \(error)")
                }
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfProducts
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        if let product = viewModel.product(at: indexPath.row) {
            cell.configure(with: product)
            cell.addToCartAction = { [weak self] in
                       if let product = self?.viewModel.product(at: indexPath.row) {
                           CartManager.shared.addItem(product)
                           
                           self?.updateProductQuantity(for: product, in: cell)
                           self?.showCartItemAddedAlert(for: product)
                       }
                   }
            cell.favoriteAction = { [weak self] product in
                           self?.toggleFavorite(for: product)
                       }
               }
        return cell
    }
    private func toggleFavorite(for product: Product) {
            if let index = favoriteProducts.firstIndex(where: { $0.id == product.id }) {
                favoriteProducts.remove(at: index)
            } else {
                favoriteProducts.append(product)
            }
            
            updateFavoritesInFavouritesController()
        }
    
    private func updateFavoritesInFavouritesController() {
          if let favouritesController = navigationController?.viewControllers.first(where: { $0 is FavouritesController }) as? FavouritesController {
              favouritesController.updateFavorites(with: favoriteProducts)
          }
      }
    
    private func updateProductQuantity(for product: Product, in cell: ProductCell) {
        if var cartProduct = CartManager.shared.cartItems.first(where: { $0.product.id == product.id }) {
            cartProduct.quantity += 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product = viewModel.product(at: indexPath.row) else { return }
        let detailVC = ProductDetailController(product: product)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 42) / 2
        return CGSize(width: width, height: 302)
    }
    
    private func showCartItemAddedAlert(for product: Product) {
        let alert = UIAlertController(title: "Added to Cart", message: "\(product.name) has been added to your cart.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
