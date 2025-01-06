import Foundation
import UIKit

class ProductDetailController: UIViewController {
    
    private let product: Product
    
    private let topView = UIView()
    private let titleLabel = UILabel()
    private let backButton = UIButton()

    private let productImageView = UIImageView()
    private let productTitleLabel = UILabel()
    private let productDescriptionLabel = UILabel()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()

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
        hideBackButton()
    }
    
    private func hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    private func setupUI() {
        view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = Colors.primary
        
        topView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Verdana-Bold", size: 18)
        titleLabel.text = product.name
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named: "Back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 51),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 51),
            titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -16),
        ])
        
        // ScrollView setup
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.contentInsetAdjustmentBehavior = .never
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // Ensures scrollable content width matches the screen
        ])
        
        contentView.addSubview(productImageView)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.contentMode = .scaleAspectFill
        if let url = URL(string: product.image) {
            productImageView.loadImage(from: url)
        }
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        contentView.addSubview(productTitleLabel)
        productTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        productTitleLabel.text = "Product: \(product.name)"
        productTitleLabel.font = UIFont(name: "Verdana", size: 18)
        productTitleLabel.textColor = .black
        
        NSLayoutConstraint.activate([
            productTitleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 48),
            productTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        contentView.addSubview(productDescriptionLabel)
        productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        productDescriptionLabel.text = "Description: \(product.description)"
        productDescriptionLabel.font = UIFont(name: "Verdana", size: 14)
        productDescriptionLabel.textColor = .gray
        productDescriptionLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            productDescriptionLabel.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: 8),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16) // Ensures scrollable content ends at the bottom
        ])
    }
    
    @objc private func backButtonTapped() {
        print("yes")
        navigationController?.popViewController(animated: true)
    }
}
