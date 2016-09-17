//
//  DetailProductViewController.swift
//  GroceriesListManager
//
//  Created by Joseph on 29/06/2016.
//  Copyright © 2016 Thunderkerrigan. All rights reserved.
//

import UIKit

class DetailProductViewController: UIViewController
{
    
    @IBOutlet weak var productDetailTextView: UITextView?
    @IBOutlet weak var productImageView: UIImageView?
    @IBOutlet weak var productTitleLabel: UILabel?
    var representedProduct: Product?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        productImageView?.image = representedProduct?.icon()
        productTitleLabel?.text = representedProduct?.name
    }
    
    @IBAction func dismissView()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}
