//
//  CategoryVC.swift
//  Screenshot Organizer
//
//  Created by Emad Beyrami on 1/25/1400 AP.
//

import UIKit

class CategoryVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var cats: [CategoryModel] {
        return DataManager.standard.items
    }
    var didSelectRow: DataAction<Int> = nil
    var selectedCategoryId: Int = 0
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    func initWith(currentCategory: Int) {
        self.selectedCategoryId = currentCategory
    }
    
    deinit {
        print("🚮 Deinit Class ####\(String(describing: self))")
    }
    
    //MARK: - functions
    
    /// Navigation Bar Setup
    func setupNavigationBar() {
        self.navigationItem.title = "Select a category"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewCategory))
    }
    
    @objc func addNewCategory() {
        var textField: UITextField?
        
        // create alertController
        let alertController = UIAlertController(title: "New Category", message: "category name", preferredStyle: .alert)
        alertController.addTextField { (pTextField) in
            pTextField.placeholder = "Screenshots"
            pTextField.clearButtonMode = .whileEditing
            pTextField.borderStyle = .none
            textField = pTextField
        }
        
        // create cancel button
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (pAction) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        // create Ok button
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (pAction) in
            // when user taps OK, you get your value here
            let inputValue = textField?.text
            let category = CategoryModel(id: self.cats.count + 1, name: inputValue ?? "null", photos: [PhotoModel]())
            DataManager.standard.addNewCategory(category)
            self.tableView.reloadData()
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        // show alert controller
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK: - TableView Delegate and Datasource
extension CategoryVC: UITableViewDelegate, UITableViewDataSource {
    /// tableView initializer
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    ///number of rows and section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    /// cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle , reuseIdentifier: "tet")
        if cats[indexPath.row].id == selectedCategoryId {
            cell.setSelected(true, animated: true)
            cell.accessoryType = cell.isSelected ? .checkmark : .none
        }
        cell.textLabel?.text = cats[indexPath.row].name
        return cell
    }
    
    /// Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow?(cats[indexPath.row].id)
        self.dismiss(animated: true)
    }
    
}
