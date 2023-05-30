//
//  myTableViewCell.swift
//  myAppUIKit
//
//  Created by Serdar Onur KARADAĞ on 30.05.2023.
//

import UIKit
import CoreData

class myTableViewCell: UITableViewCell {
    
    static let identifier = "myTableViewCell"
    
    private let myFoodCalorie: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
 
    private let myFoodName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(myFoodName)
        contentView.addSubview(myFoodCalorie)

        
        addConstraintsTo()
        

    }
    
    func configure(with food: Food) {
        myFoodName.text = "Name: \(food.name ?? "")"
        myFoodCalorie.text = "Calorie: \(food.calorie)"
    }
    
    private func addConstraintsTo() {
        let labelConstraints = [
            myFoodName.topAnchor.constraint(equalTo: contentView.topAnchor),
            myFoodName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ]
        let calorieConstraints = [
            myFoodCalorie.topAnchor.constraint(equalTo: contentView.topAnchor),
            myFoodCalorie.leadingAnchor.constraint(equalTo: myFoodName.trailingAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
        NSLayoutConstraint.activate(calorieConstraints)
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
