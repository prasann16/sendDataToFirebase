//
//  ViewController.swift
//  sendDataToFirebase
//
//  Created by Prasann Pandya on 2017-08-27.
//  Copyright © 2017 Prasann Pandya. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet var storeCategory: UITextField!
    @IBOutlet var storeName: UITextField!
    @IBOutlet var storeLocation: UITextField!
    @IBOutlet var storeImage: UITextField!
    @IBOutlet var productCategory: UITextField!
    @IBOutlet var productName: UITextField!
    @IBOutlet var productImage: UITextField!
    @IBOutlet var productPrice: UITextField!
    @IBOutlet var productInfo: UITextField!
    
    @IBOutlet var showProductInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postData(_ sender: Any) {
        
//        TODO: Store values to database
        let ref = Database.database().reference()
        let storesDB = ref.child(storeCategory.text!).child(storeName.text!)
        
//        TODO: Saving values in Database
//        let storeDict = ["Store Location":storeLocation.text!,"Store Image":storeImage.text!]
//        storesDB.setValue(storeDict)
//        let productDict = ["Product Image":productImage.text!, "Product price":productPrice.text!, "Product Info":productInfo.text!]
        let productDB = storesDB.child(productCategory.text!).child(productName.text!)
//        productDB.setValue(productDict)
        
//        TODO: Updating value
        productDB.updateChildValues(["Product Info":"not the best laptop"])
        
//         TODO: Reading values from database
//        productDB.child("Product Info").observe(.value) { (snapshot: DataSnapshot) in
//            let snapshotValue = snapshot.value as! String
//            self.showProductInfo.text = snapshotValue
//            
//            
//        }
        
        
        
    }
    
}

