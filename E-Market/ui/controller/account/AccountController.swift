//
//  AccountController.swift
//  E-Market
//
//  Created by gizem on 5.01.2025.
//

import Foundation
import UIKit

class AccountController: UIViewController, UITextFieldDelegate {
    
    private let topView = UIView()
    private let titleLabel = UILabel()
    
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    private let favouritesButton = UIButton()
    
    private let userDefaultsService = UserDefaultsService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        loadSavedData()
        nameTextField.delegate = self
        surnameTextField.delegate = self

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          dismissKeyboard()
          return true
      }
    
    private func setupUI() {
        
        nameTextField.returnKeyType = .done
        surnameTextField.returnKeyType = .done

        view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = Colors.primary
        
        topView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "Verdana-Bold", size: 24)
        titleLabel.text = "Account"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "Name"
        nameTextField.font = UIFont(name: "Verdana", size: 18)
        nameTextField.borderStyle = .roundedRect
        nameTextField.textColor = .primary
        nameTextField.backgroundColor = Colors.secondary
        view.addSubview(nameTextField)
        
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        surnameTextField.placeholder = "Surname"
        surnameTextField.font = UIFont(name: "Verdana", size: 18)
        surnameTextField.borderStyle = .roundedRect
        surnameTextField.textColor = .primary
        surnameTextField.backgroundColor = Colors.secondary
        view.addSubview(surnameTextField)
        
        favouritesButton.translatesAutoresizingMaskIntoConstraints = false
        favouritesButton.setTitle("Go to Favourites", for: .normal)
        favouritesButton.backgroundColor = Colors.primary
        favouritesButton.setTitleColor(.white, for: .normal)
        favouritesButton.addTarget(self, action: #selector(favouritesButtonTapped), for: .touchUpInside)
        view.addSubview(favouritesButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 51),
            titleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -16),
            
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 100),
            
            nameTextField.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 30),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            surnameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            favouritesButton.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 30),
            favouritesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favouritesButton.heightAnchor.constraint(equalToConstant: 44),
            favouritesButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func loadSavedData() {
        let defaults = UserDefaults.standard
        if let savedName = defaults.string(forKey: "userName") {
            nameTextField.text = savedName
        }
        if let savedSurname = defaults.string(forKey: "userSurname") {
            surnameTextField.text = savedSurname
        }
    }
    
    @objc private func favouritesButtonTapped() {
        if let tabBarController = tabBarController {
            tabBarController.selectedIndex = 2
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveUserData()
    }
    
    private func saveUserData() {
        userDefaultsService.saveString(nameTextField.text, forKey: "userName")
        userDefaultsService.saveString(surnameTextField.text, forKey: "userSurname")
    }
}
