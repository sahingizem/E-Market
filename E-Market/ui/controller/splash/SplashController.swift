//
//  SplashController.swift
//  E-Market
//
//  Created by gizem on 5.01.2025.
//


import UIKit

class SplashController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "E-Market"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigateToTabbar()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func navigateToTabbar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let tabbarController = TabBarController()
            tabbarController.modalTransitionStyle = .crossDissolve
            tabbarController.modalPresentationStyle = .fullScreen
            self.present(tabbarController, animated: true, completion: nil)
        }
    }
}
