//
//  ItemDetailVC.swift
//  Wish
//
//  Created by Ben on 5/12/17.
//  Copyright © 2017 Ben. All rights reserved.
//

import UIKit
import CoreData


class ItemDetailVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var details: UITextField!
    @IBOutlet weak var price: UITextField!
  
    @IBOutlet weak var thumbImage: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storePicker.delegate = self
        storePicker.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
//        let store = Store(context: context)
//        store.name = "Best Buy"
//        
//        let store1 = Store(context: context)
//        store1.name = "Amazon"
//        
//        let store2 = Store(context: context)
//        store2.name = "Apple"
//        
//        let store3 = Store(context: context)
//        store3.name = "Microsoft"
//        
//        let store4 = Store(context: context)
//        store4.name = "ATT"
//        
//        let store5 = Store(context: context)
//        store5.name = "Game Stop"
//        
//        let store6 = Store(context: context)
//        store6.name = "Tesla"
//        
//        let store7 = Store(context: context)
//        store7.name = "Fry's Electronics"
        
        //ad.saveContext()
        

        
        getStores()
        
        if itemToEdit != nil {
            
            loadItemData()
        }
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
        
        var item: Item!
        
        let picture = Image(context: context)
        picture.image = thumbImage.image
        
        if itemToEdit == nil {
            item = Item(context: context)
            
        } else {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = itemTitle.text {
            item.title = title
        }
        
        if let price = price.text {
            item.price = Double(price)!
        }
        
        if let details = details.text {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
        
    }
    
    func loadItemData() {
        if let item = itemToEdit {
            
            itemTitle.text = item.title
            price.text = String(item.price)
            details.text = item.details
            thumbImage.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                var index = 0
                
                repeat {
                    
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    
                    index += 1
                } while (index < stores.count)
            }
        }
    }
   
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit !=  nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImage.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
