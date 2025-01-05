//
//  FilterController.swift
//  E-Market
//
//  Created by gizem on 5.01.2025.
//

import Foundation
import UIKit

class FilterController: UIViewController {
    
    private let topView = UIView()
    private let closeButton = UIButton()
    private let filterLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .white
        view.addSubview(topView)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(named: "Close"), for: .normal)
        closeButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        topView.addSubview(closeButton)
        
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.text = "Filter"
        filterLabel.font = UIFont(name: "Verdana", size: 20)
        filterLabel.textAlignment = .center
        topView.addSubview(filterLabel)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            closeButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            filterLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            filterLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor)
        ])
    }
    
    @objc private func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
