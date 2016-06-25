//
//  SecondViewController.swift
//  GroceriesListManager
//
//  Created by Joseph on 03/06/2016.
//  Copyright © 2016 Thunderkerrigan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var selectedProductsArray: [Product] = []
    @IBOutlet weak var listTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listTableView.delegate = self
        listTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension SecondViewController : AddGroceryDelegate
{
    //MARK: AddGroceryDelegate
    func addGroceriesToList(aGroceryItem groceryItem: Product) -> Bool
    {
        selectedProductsArray.append(groceryItem)
        selectedProductsArray.sort { (firstProduct, secondProduct) -> Bool in
            return firstProduct.name < secondProduct.name
        }
        listTableView?.reloadData()
        return true
    }
}

extension SecondViewController : UITableViewDataSource
{
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return selectedProductsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let tableViewCell : ProductTableViewCell! = tableView.dequeueReusableCell(withIdentifier:"ProductCellIdentifier") as! ProductTableViewCell
        let product = selectedProductsArray[indexPath.row]
        tableViewCell.productNameLabel.text = product.name
        tableViewCell.productImageview.image = product.icon()
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
}

extension SecondViewController : UITableViewDelegate
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

