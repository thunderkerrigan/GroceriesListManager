//
//  FirstViewController.swift
//  GroceriesListManager
//
//  Created by Joseph on 03/06/2016.
//  Copyright © 2016 Thunderkerrigan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController
{
    
    @IBOutlet weak var tableView: UITableView?
    var productsByMonthsArray: Array<AnyObject>?
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
        
        if let path = Bundle.main().pathForResource("VegetablesByMonths", ofType: "json")
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
            return UIColor.clear()
        }
    }
    
    func icon(forType type: NSInteger) -> UIImage
    {
        switch type
        {
        case 0:
            return #imageLiteral(resourceName: "vegetable")
        case 1:
            return #imageLiteral(resourceName: "fruit")
        default:
            return UIImage()
        }
    }
    
    func product(atSection section: NSInteger, andRow row: NSInteger) -> Dictionary<String, AnyObject>{
        let currentMonthProducts: Dictionary<String, AnyObject> = (productsByMonthsArray![section] as? Dictionary)!
        let products: Array<AnyObject> = currentMonthProducts.first?.value as! Array
        let product: Dictionary<String, AnyObject> = products[row] as! Dictionary<String, AnyObject>
        return product
    }
    
    func removeProduct(atIndexPath indexPath: IndexPath) {
        let currentMonthProducts: Dictionary<String, AnyObject> = (productsByMonthsArray![indexPath.section] as? Dictionary)!
        var products: Array<AnyObject> = currentMonthProducts.first?.value as! Array
        products.remove(at: indexPath.row)
        let productDictionary: Dictionary<String, AnyObject> = [(currentMonthProducts.first?.key)! : products]
        productsByMonthsArray![indexPath.section] = productDictionary
    }
}

extension FirstViewController : UITableViewDataSource
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
        tableViewCell.productNameLabel.text = product["Nom"] as? String
        tableViewCell.productImageview.image = self.icon(forType: (product["type"] as! NSInteger))
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

extension FirstViewController : UITableViewDelegate
{
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let tableViewRowAction: UITableViewRowAction? = UITableViewRowAction(style: .destructive , title: "Effacer", handler: { (_, indexPath) in
            //TODO
            self.removeProduct(atIndexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        })
        return [tableViewRowAction!]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let product = self.product(atSection: indexPath.section, andRow: indexPath.row)
        let alertViewController: UIAlertController = UIAlertController(title: "Click", message: String(format: "click on %@", product["Nom"] as! String), preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertViewController, animated: true, completion: nil)
    }
}
