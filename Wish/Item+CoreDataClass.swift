//
//  Item+CoreDataClass.swift
//  Wish
//
//  Created by Ben on 5/11/17.
//  Copyright © 2017 Ben. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
    
}
