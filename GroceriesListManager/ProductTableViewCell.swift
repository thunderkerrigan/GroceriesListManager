//
//  ProductTableViewCell.swift
//  GroceriesListManager
//
//  Created by Joseph on 23/06/2016.
//  Copyright © 2016 Thunderkerrigan. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell
{
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageview: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
