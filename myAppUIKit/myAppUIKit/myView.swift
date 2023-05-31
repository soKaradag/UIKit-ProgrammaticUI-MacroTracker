//
//  myView.swift
//  myAppUIKit
//
//  Created by Serdar Onur KARADAĞ on 30.05.2023.
//

import UIKit
import CoreData

class myView: UIView {
    private var context: NSManagedObjectContext = {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let myContext = appDelegate.persistentContainer.viewContext
            return myContext
        }
        fatalError("Unable to retrieve NSManagedObjectContext")
    }()
    
    private var dataController: DataController {
        let controller = DataController(context: context)
        return controller
    }
    
    private lazy var addFoodButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Food", for: .normal)
        button.addTarget(self, action: #selector(addFoodButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemBackground
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.backgroundColor = .label
        return button
    }()

    @objc private func addFoodButtonTapped() {
        guard let name = myTextField.text, let calorieText = myTextCalorie.text, let calorie = Int(calorieText) else {
            return
        }
        dataController.addFood(name: name, calorie: Int32(calorie))
        print("Add Food Button Tapped")
    }
    
    private let myTextField: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.placeholder = "Name"
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        label.leftView = paddingView
        label.leftViewMode = .always
        return label
    }()
    
    private let myTextCalorie: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.placeholder = "Calorie"
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        label.leftView = paddingView
        label.leftViewMode = .always
        label.keyboardType = .numberPad
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(myTextField)
        addSubview(myTextCalorie)
        addSubview(addFoodButton)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
        
        myTextField.inputAccessoryView = createDoneToolbar()
        myTextCalorie.inputAccessoryView = createDoneToolbar()

        applyConstraints()
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
    
    private func createDoneToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        return toolbar
    }
    
    // Method to handle "Done" button tap
    @objc private func doneButtonTapped() {
        self.endEditing(true)
    }
    
    private func applyConstraints() {
        let myLabelConstraints = [
            myTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            myTextField.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            myTextField.widthAnchor.constraint(equalToConstant: 150)
        ]
        let myTextCalorieConstraints = [
            myTextCalorie.leadingAnchor.constraint(equalTo: myTextField.trailingAnchor, constant: 20),
            myTextCalorie.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            myTextCalorie.widthAnchor.constraint(equalToConstant: 150)
        ]
        let addFoodButtonConstraints = [
            addFoodButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            addFoodButton.topAnchor.constraint(equalTo: myTextField.bottomAnchor, constant: 20),
            addFoodButton.widthAnchor.constraint(equalToConstant: 100),
            addFoodButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(myLabelConstraints)
        NSLayoutConstraint.activate(myTextCalorieConstraints)
        NSLayoutConstraint.activate(addFoodButtonConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
