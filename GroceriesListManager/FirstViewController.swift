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
    var productsDic: NSMutableDictionary?
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
        
        if let path = Bundle.main().pathForResource("VegetablesByMonths", ofType: "json")
        {
            if let jsonData: Data = try! Data(contentsOf: URL(fileURLWithPath: path))
            {
                if let jsonDic: NSMutableDictionary = try! JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! NSMutableDictionary
                {
                    productsDic = jsonDic
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
        return (productsDic?.allKeys.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //TODO
        let keys: Array = (productsDic?.allKeys)!
        let values: Array = productsDic?.keyEnumerator().value(forUndefinedKey: keys[section] as! String) as! [AnyObject]
        return values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let tableViewCell : UITableViewCell! = UITableViewCell()
//        tableViewCell.textLabel?.text = productsArray![(indexPath as NSIndexPath).row] as? String
        tableViewCell.backgroundColor = self.randomColor(Int(arc4random_uniform(4)))
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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
