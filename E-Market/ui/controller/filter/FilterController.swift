//
//  FilterController.swift
//  E-Market
//
//  Created by gizem on 5.01.2025.
//

import Foundation
import UIKit

class FilterController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    private var selectedRows: Set<Int> = []

    private let topView = UIView()
    private let closeButton = UIButton()
    private let filterLabel = UILabel()
    private let lineView = UIView()
    private let sortByLabel = UILabel()
    
    private var roundButtons: [UIButton] = []
    private var buttonLabels: [UILabel] = []
    
    private let secondLineView = UIView()
    private let modelLabel = UILabel()
    private let searchTextField: UITextField = {
            let textField = UITextField()
        textField.returnKeyType = .done

        textField.placeholder = "Search"
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
            textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.leftView = UIImageView(image: UIImage(named: "Search"))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 8
        textField.backgroundColor = Colors.tertiary
        textField.font = UIFont(name: "Verdana", size: 14)
           textField.textColor = .black
           textField.returnKeyType = .done
            return textField
        }()

        private let brandTableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.backgroundColor = .white
            tableView.separatorStyle = .none
            tableView.rowHeight = 30
            return tableView
        }()

    private let modelSearchTextField: UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done

        textField.placeholder = "Search"
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.leftView = UIImageView(image: UIImage(named: "Search"))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 8
        textField.backgroundColor = Colors.tertiary
        textField.font = UIFont(name: "Verdana", size: 14)
        textField.textColor = .black
        textField.returnKeyType = .done
        return textField
    }()

    private let modelTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = 30
        return tableView
    }()

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
         return true
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideBackButton()
        searchTextField.delegate = self
        modelSearchTextField.delegate = self
        modelTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
             
             brandTableView.dataSource = self
             brandTableView.delegate = self
             modelTableView.dataSource = self
             modelTableView.delegate = self
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
        
        let buttonTitles = ["Old to new", "New to old", "Price high to low", "Price low to high"]
               
        for (_, title) in buttonTitles.enumerated() {
                   let button = UIButton()
                   button.translatesAutoresizingMaskIntoConstraints = false
                   button.setImage(UIImage(named: "unselectedButton"), for: .normal)
                   button.widthAnchor.constraint(equalToConstant: 16).isActive = true
                   button.heightAnchor.constraint(equalToConstant: 16).isActive = true
                   button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                   roundButtons.append(button)
                   view.addSubview(button)
                   
                   let label = UILabel()
                   label.translatesAutoresizingMaskIntoConstraints = false
                   label.text = title
                   label.font = UIFont(name: "Verdana", size: 14)
                   label.textColor = .black
                   buttonLabels.append(label)
                   view.addSubview(label)
               }
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 51),
            closeButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
       //     closeButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
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
        
        for (index, button) in roundButtons.enumerated() {
                    if index == 0 {
                        NSLayoutConstraint.activate([
                            button.topAnchor.constraint(equalTo: sortByLabel.bottomAnchor, constant: 31),
                            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31)
                        ])
                        NSLayoutConstraint.activate([
                            buttonLabels[index].centerYAnchor.constraint(equalTo: button.centerYAnchor),
                            buttonLabels[index].leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 9)
                        ])
                    } else {
                        NSLayoutConstraint.activate([
                            button.topAnchor.constraint(equalTo: roundButtons[index - 1].bottomAnchor, constant: 15),
                            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31)
                        ])
                        NSLayoutConstraint.activate([
                            buttonLabels[index].centerYAnchor.constraint(equalTo: button.centerYAnchor),
                            buttonLabels[index].leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 9)
                        ])
                    }
            
                }
        let lineImageView = UIImageView()
           lineImageView.translatesAutoresizingMaskIntoConstraints = false
           lineImageView.image = UIImage(named: "Line")
           view.addSubview(lineImageView)
           
           NSLayoutConstraint.activate([
               lineImageView.topAnchor.constraint(equalTo: roundButtons.last!.bottomAnchor, constant: 33),
               lineImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
               lineImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
               lineImageView.heightAnchor.constraint(equalToConstant: 1)
           ])
        
        let brandLabel = UILabel()
            brandLabel.translatesAutoresizingMaskIntoConstraints = false
            brandLabel.text = "Brand"
            brandLabel.font = UIFont(name: "Verdana", size: 12)
            brandLabel.textColor = .black
            view.addSubview(brandLabel)
            
            NSLayoutConstraint.activate([
                brandLabel.topAnchor.constraint(equalTo: lineImageView.bottomAnchor, constant: 15),
                brandLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)
            ])
        view.addSubview(searchTextField)
               view.addSubview(brandTableView)

               NSLayoutConstraint.activate([

                   searchTextField.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 24),
                   searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
                   searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
                   searchTextField.heightAnchor.constraint(equalToConstant: 40),

                   brandTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 16),
                   brandTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
                   brandTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
                   brandTableView.heightAnchor.constraint(equalToConstant: 90)
               ])

               brandTableView.dataSource = self
               brandTableView.delegate = self
        
        secondLineView.translatesAutoresizingMaskIntoConstraints = false
        secondLineView.backgroundColor = Colors.secondary
               view.addSubview(secondLineView)
               
               NSLayoutConstraint.activate([
                secondLineView.topAnchor.constraint(equalTo: brandTableView.bottomAnchor, constant: 33),
                secondLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
                secondLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
                secondLineView.heightAnchor.constraint(equalToConstant: 1)
               ])
        modelLabel.translatesAutoresizingMaskIntoConstraints = false
                modelLabel.text = "Model"
                modelLabel.font = UIFont(name: "Verdana", size: 12)
                modelLabel.textColor = .black
                view.addSubview(modelLabel)
                
                NSLayoutConstraint.activate([
                    modelLabel.topAnchor.constraint(equalTo: secondLineView.bottomAnchor, constant: 15),
                    modelLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18)
                ])
        
        view.addSubview(modelSearchTextField)

        NSLayoutConstraint.activate([
            modelSearchTextField.topAnchor.constraint(equalTo: modelLabel.bottomAnchor, constant: 24),
            modelSearchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            modelSearchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            modelSearchTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(modelTableView)
        NSLayoutConstraint.activate([
        modelTableView.topAnchor.constraint(equalTo: modelSearchTextField.bottomAnchor, constant: 16),
                   modelTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
                   modelTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
                   modelTableView.heightAnchor.constraint(equalToConstant: 90),
               ])
        view.addSubview(modelTableView)
                modelTableView.translatesAutoresizingMaskIntoConstraints = false
                modelTableView.backgroundColor = .white
                modelTableView.separatorStyle = .none
                modelTableView.rowHeight = 30

                NSLayoutConstraint.activate([
                    modelTableView.topAnchor.constraint(equalTo: modelSearchTextField.bottomAnchor, constant: 16),
                    modelTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
                    modelTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
                    modelTableView.heightAnchor.constraint(equalToConstant: 90)
                ])
        
        
            }
    
    @objc private func buttonTapped(_ sender: UIButton) {
           sender.isSelected.toggle()
           // unselect selected button(s) when another one gets selected by the user:
        for button in roundButtons {
               button.isSelected = false
               button.setImage(UIImage(named: "unselectedButton"), for: .normal)
           }
        sender.isSelected = true
            sender.setImage(UIImage(named: "selectedButton"), for: .normal)
        }
    
    
    @objc private func dismissViewController() {
        print("close button is user interactable")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func toggleSelection(_ sender: UITapGestureRecognizer) {
        guard let cell = sender.view else { return }
            
            if selectedRows.contains(cell.tag) {
                selectedRows.remove(cell.tag)
            } else {
                selectedRows.insert(cell.tag)
            }
            
            brandTableView.reloadData()
        }
    
}

extension FilterController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")

        let iconImageView = UIImageView()
               iconImageView.translatesAutoresizingMaskIntoConstraints = false

        let isSelected = selectedRows.contains(indexPath.row)
        iconImageView.image = UIImage(named: isSelected ? "selectedCheckbox" : "unselectedCheckbox")

        iconImageView.tintColor = .black
               iconImageView.layer.cornerRadius = 4
               iconImageView.clipsToBounds = true
               
                
                cell.contentView.addSubview(iconImageView)

                NSLayoutConstraint.activate([
                    iconImageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 0),
                    iconImageView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                    iconImageView.widthAnchor.constraint(equalToConstant: 16),
                    iconImageView.heightAnchor.constraint(equalToConstant: 16)
                ])

                cell.textLabel?.text = "Brand \(indexPath.row + 1)"
                cell.textLabel?.font = UIFont(name: "Verdana", size: 14)
                cell.textLabel?.textColor = .black
                cell.textLabel?.backgroundColor = .white
                
                cell.textLabel?.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    cell.textLabel!.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
                    cell.textLabel!.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -8),
                    cell.textLabel!.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
                ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleSelection(_:)))
                cell.contentView.addGestureRecognizer(tapGesture)
                cell.tag = indexPath.row

        cell.backgroundColor = .white
        let selectedBackgroundView = UIView()
                selectedBackgroundView.backgroundColor = .clear
                cell.selectedBackgroundView = selectedBackgroundView
                return cell
            }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if selectedRows.contains(indexPath.row) {
               selectedRows.remove(indexPath.row)
           } else {
               selectedRows.insert(indexPath.row)
           }
           
           tableView.reloadRows(at: [indexPath], with: .automatic)
       }
   }
