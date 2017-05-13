//
//  ItemCell.swift
//  Wish
//
//  Created by Ben on 5/11/17.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit
import CoreData

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var price: UILabel!
    
    func configureCell(item: Item) {
        title.text = item.title
        price.text = String(item.price)
        details.text = item.details
        thumb.image = item.toImage?.image as? UIImage
    }
    
}
