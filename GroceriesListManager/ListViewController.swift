//
//  SecondViewController.swift
//  GroceriesListManager
//
//  Created by Joseph on 03/06/2016.
//  Copyright © 2016 Thunderkerrigan. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var selectedProductsArray: [Product] = []
    var filteredProductsArray: [Product] = []
    @IBOutlet weak var listTableView: UITableView!
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listTableView.delegate = self
        listTableView.dataSource = self
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        listTableView.tableHeaderView = searchController.searchBar
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }


}

extension ListViewController : AddGroceryDelegate
{
    //MARK: AddGroceryDelegate
    func addGroceriesToList(aGroceryItem groceryItem: Product) -> Bool
    {
        if !selectedProductsArray.contains({ (item: Product) -> Bool in
            return item.name == groceryItem.name
        }) {
            selectedProductsArray.append(groceryItem)
            selectedProductsArray.sort { (firstProduct, secondProduct) -> Bool in
                return firstProduct.name.lowercased() < secondProduct.name.lowercased()
            }
            listTableView?.reloadData()
        }
        
        return true
    }
}

extension ListViewController : UITableViewDataSource
{
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if searchController.searchBar.isFirstResponder()
        {
            return filteredProductsArray.count
        }
        else
        {
            return selectedProductsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let tableViewCell : ProductTableViewCell! = tableView.dequeueReusableCell(withIdentifier:"ProductCellIdentifier") as! ProductTableViewCell
        
        var product: Product
        if searchController.searchBar.isFirstResponder()
        {
            product = filteredProductsArray[indexPath.row]
        }
        else
        {
            product = selectedProductsArray[indexPath.row]
        }
        
        tableViewCell.productNameLabel.text = product.name
        tableViewCell.productImageview.image = product.icon()
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
}

extension ListViewController : UITableViewDelegate
{
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let tableViewRowAction: UITableViewRowAction? = UITableViewRowAction(style: .destructive , title: "Effacer", handler: { (_, indexPath) in
            //TODO
            self.selectedProductsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        })
        return [tableViewRowAction!]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let product = selectedProductsArray[indexPath.row]
        let alertViewController: UIAlertController = UIAlertController(title: "Click", message: String(format: "click on %@", product.name), preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertViewController, animated: true, completion: nil)
    }
}

extension ListViewController : UISearchResultsUpdating
{
    //MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController)
    {
        if searchController.searchBar.text != ""
        {
            filteredProductsArray = selectedProductsArray.filter({ (product) -> Bool in
                return product.name.lowercased().contains((searchController.searchBar.text?.lowercased())!)
            })
        }
        else
        {
            filteredProductsArray = selectedProductsArray
        }
        
        self.listTableView.reloadData()
    }
    
}

