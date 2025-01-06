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
    private let lineView = UIView()
    private let sortByLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideBackButton()
    }
    
    private func hideBackButton() {
        self.navigationItem.hidesBackButton = true
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
        filterLabel.textColor = .black
        filterLabel.textAlignment = .center
        topView.addSubview(filterLabel)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = Colors.secondary
        lineView.layer.shadowColor = UIColor.gray.cgColor
              lineView.layer.shadowOffset = CGSize(width: 0, height: 2)
              lineView.layer.shadowOpacity = 0.5
              lineView.layer.shadowRadius = 4
               topView.addSubview(lineView)
        
        sortByLabel.translatesAutoresizingMaskIntoConstraints = false
            sortByLabel.text = "Sort By"
            sortByLabel.font = UIFont(name: "Verdana", size: 12)
            sortByLabel.textColor = .black
            topView.addSubview(sortByLabel)
            
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 51),
            closeButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            closeButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 53),
            filterLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
                    lineView.topAnchor.constraint(equalTo: topView.bottomAnchor),
                    lineView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
                    lineView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
                    lineView.heightAnchor.constraint(equalToConstant: 1)
                ])
        
        NSLayoutConstraint.activate([
               sortByLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 16),
               sortByLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
           ])
    }
    
    @objc private func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
