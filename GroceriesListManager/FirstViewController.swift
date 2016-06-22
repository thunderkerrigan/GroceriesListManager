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
    var productsMutableArray: NSMutableArray?
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
        
        if let path = Bundle.main().pathForResource("VegetablesByMonths", ofType: "json")
        {
            if let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: path))
            {
                if let jsonMutableArray: NSMutableArray = try! JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! NSMutableArray
                {
                    productsMutableArray = jsonMutableArray
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
            return UIColor.blue()
        case 1:
            return UIColor.red()
        case 2:
            return UIColor.purple()
        case 3:
            return UIColor.green()
        case 4:
            return UIColor.cyan()
        default:
            return UIColor.clear()
        }
    }
}

extension FirstViewController : UITableViewDataSource
{
    //MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int
    {
        //TODO
        return (productsMutableArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //TODO
        if let productForMonth :Dictionary<String, AnyObject> = productsMutableArray![section] as? Dictionary
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
        let tableViewCell : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier:"ProductCellIdentifier")
        let currentMonthProducts: Dictionary<String, AnyObject> = (productsMutableArray![indexPath.section] as? Dictionary)!
        let products: Array<AnyObject> = currentMonthProducts.first?.value as! Array
        let product: Dictionary<String, AnyObject> = products[indexPath.row] as! Dictionary<String, AnyObject>
        
        
        
        tableViewCell.textLabel?.text = product["Nom"] as? String
        tableViewCell.backgroundColor = self.randomColor(product["type"] as! NSInteger)
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let currentMonthProducts: Dictionary<String, AnyObject> = (productsMutableArray![section] as? Dictionary)!
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
//            self.productsArray!.removeObject(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        })
        return [tableViewRowAction!]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        let alertViewController: UIAlertController = UIAlertController(title: "Click", message: String(format: "click on %@", self.productsArray![(indexPath as NSIndexPath).row] as! String), preferredStyle: .alert)
//        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
//            self.dismiss(animated: true, completion: nil)
//        }))
//        self.present(alertViewController, animated: true, completion: nil)
    }
}
