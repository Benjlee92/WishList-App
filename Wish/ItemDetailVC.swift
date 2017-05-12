//
//  ItemDetailVC.swift
//  Wish
//
//  Created by Ben on 5/12/17.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit
import CoreData


class ItemDetailVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var details: UITextField!
    @IBOutlet weak var price: UITextField!
    
    var stores = [Store]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        let store = Store(context: context)
        store.name = "Best Buy"
        
        let store1 = Store(context: context)
        store1.name = "Amazon"
        
        let store2 = Store(context: context)
        store2.name = "Apple"
        
        let store3 = Store(context: context)
        store3.name = "Microsoft"
        
        let store4 = Store(context: context)
        store4.name = "ATT"
        
        let store5 = Store(context: context)
        store5.name = "Game Stop"
        
        let store6 = Store(context: context)
        store6.name = "Tesla"
        
        let store7 = Store(context: context)
        store7.name = "Fry's Electronics"
        
        ad.saveContext()
        
        getStores()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        return store.name
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //UPDATE WHEN SELECTED
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            // Handle error
        }
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        
    }

}
