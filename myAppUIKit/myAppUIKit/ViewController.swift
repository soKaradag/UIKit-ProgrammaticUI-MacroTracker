//
//  ViewController.swift
//  myAppUIKit
//
//  Created by Serdar Onur KARADAĞ on 30.05.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {
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
    
    private var foods: [Food] {
        if let fetchedFoods = dataController.fetchFoods() {
            return fetchedFoods
        } else {
            print("No foods fetched")
            return []
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(myTableViewCell.self, forCellReuseIdentifier:myTableViewCell.identifier )
        table.separatorStyle = .none
        return table
    }()
    
    private let customView: myView = {
        let view = myView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .label
        label.text = "Macro Tracker"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        view.addSubview(customView)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setConstraints()
        
    }
    
    private func setConstraints() {
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ]
        
        
        let customViewConstraints = [
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            customView.heightAnchor.constraint(equalToConstant: 120)
        ]
        
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: customView.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(customViewConstraints)
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: myTableViewCell.identifier, for: indexPath) as? myTableViewCell else { return UITableViewCell() }
        cell.configure(with: foods[indexPath.row])
        return cell
    }

}
