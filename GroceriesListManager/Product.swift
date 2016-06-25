//
//  Product.swift
//  GroceriesListManager
//
//  Created by Joseph on 25/06/2016.
//  Copyright © 2016 Thunderkerrigan. All rights reserved.
//

import UIKit

struct Product
{
    let name: String
    let type: NSInteger
    
    init(_ nameOfProduct: String, _ typeOfProduct: NSInteger) {
        name = nameOfProduct
        type = typeOfProduct
    }
    init(_ productDictionary: Dictionary<String, AnyObject>)
    {
        name = (productDictionary["Nom"] as? String)!
        type = (productDictionary["type"] as? NSInteger)!
    }
    
    func icon() -> UIImage {
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
}

