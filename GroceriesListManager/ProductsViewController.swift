//
//  FirstViewController.swift
//  GroceriesListManager
//
//  Created by Joseph on 03/06/2016.
//  Copyright © 2016 Thunderkerrigan. All rights reserved.
//

import UIKit

protocol AddGroceryDelegate
{
    func addGroceriesToList(aGroceryItem groceryItem: Product) -> Bool
    //    func removeGroceriesToList(aGroceryItem groceryItem: Dictionary<String, AnyObject>) -> Bool
}

class ProductsViewController: UIViewController
{
    
    @IBOutlet weak var tableView: UITableView?
    var productsByMonthsArray: Array<AnyObject>?
    var listDelegate: AddGroceryDelegate?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
        
        //atributing AddGroceryDelegate
        let parentViewController = self.parent
        
        if parentViewController is UITabBarController
        {
            //todo
            if let listViewController = parentViewController?.childViewControllers[1]
            {
                listDelegate = listViewController as? AddGroceryDelegate
            }
        }
        
        if let path =  Bundle.main.path(forResource: "VegetablesByMonths", ofType: "json")
        {
            if let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: path))
            {
                if let jsonMutableArray: Array<AnyObject> = try! JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! Array<AnyObject>
                {
                    productsByMonthsArray = jsonMutableArray
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "ShowDetailProductSegue")
        {
            let destination: DetailProductViewController = segue.destination as! DetailProductViewController
            let __indexPath: IndexPath = (tableView?.indexPathForSelectedRow)!
            destination.representedProduct =  self.product(atSection: __indexPath.section, andRow: __indexPath.row)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func randomColor(_ number: NSInteger) -> UIColor {
        switch number
        {
        case 0:
            return #colorLiteral(red: 0.1603052318, green: 0, blue: 0.8195188642, alpha: 1)
        case 1:
            return #colorLiteral(red: 0.7540004253, green: 0, blue: 0.2649998069, alpha: 1)
        case 2:
            return #colorLiteral(red: 0.4776530862, green: 0.2292086482, blue: 0.9591622353, alpha: 1)
        case 3:
            return #colorLiteral(red: 0.9446166754, green: 0.6509571671, blue: 0.1558967829, alpha: 1)
        case 4:
            return #colorLiteral(red: 0.2818343937, green: 0.5693024397, blue: 0.1281824261, alpha: 1)
        default:
            return UIColor.clear
        }
    }
    
    func product(atSection section: NSInteger, andRow row: NSInteger) -> Product{
        let currentMonthProducts: Dictionary<String, AnyObject> = (productsByMonthsArray![section] as? Dictionary)!
        let products: Array<AnyObject> = currentMonthProducts.first?.value as! Array
        let product: Product = Product(products[row] as! Dictionary<String, AnyObject>)
        return product
    }
    
    func removeProduct(atIndexPath indexPath: IndexPath) {
        let currentMonthProducts: Dictionary<String, AnyObject> = (productsByMonthsArray![indexPath.section] as? Dictionary)!
        var products: Array<AnyObject> = currentMonthProducts.first?.value as! Array
        products.remove(at: indexPath.row)
        let productDictionary: Dictionary<String, AnyObject> = [(currentMonthProducts.first?.key)! : products as AnyObject]
        productsByMonthsArray![indexPath.section] = productDictionary as AnyObject
    }
}

extension ProductsViewController : UITableViewDataSource
{
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int
    {
        //TODO
        return (productsByMonthsArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //TODO
        if let productForMonth :Dictionary<String, AnyObject> = productsByMonthsArray![section] as? Dictionary
        {
            return (productForMonth[productForMonth.keys.first!]?.count)!
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let tableViewCell : ProductTableViewCell! = tableView.dequeueReusableCell(withIdentifier:"ProductCellIdentifier") as! ProductTableViewCell
        let product = self.product(atSection: indexPath.section, andRow: indexPath.row)
        tableViewCell.productNameLabel.text = product.name
        tableViewCell.productImageview.image = product.icon()
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        let currentMonthProducts: Dictionary<String, AnyObject> = (productsByMonthsArray![section] as? Dictionary)!
        return currentMonthProducts.first?.key
    }
}

extension ProductsViewController : UITableViewDelegate
{
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let addToListViewRowAction: UITableViewRowAction? = UITableViewRowAction(style: .default , title: "Ajouter", handler: { (_, indexPath) in
            let product = self.product(atSection: indexPath.section, andRow: indexPath.row)
            _ = self.listDelegate?.addGroceriesToList(aGroceryItem: product)
            tableView.setEditing(false, animated: true)
        })
        addToListViewRowAction?.backgroundColor = #colorLiteral(red: 0.4028071761, green: 0.7315050364, blue: 0.2071235478, alpha: 1)
        
        return [addToListViewRowAction!]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let product = self.product(atSection: indexPath.section, andRow: indexPath.row)
    }
}
