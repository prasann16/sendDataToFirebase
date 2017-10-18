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

//    @IBOutlet var storeCategory: UITextField!
    @IBOutlet var storeName: UITextField!
    @IBOutlet var storeLocation: UITextField!
//    @IBOutlet var storeImage: UITextField!
//    @IBOutlet var productCategory: UITextField!
//    @IBOutlet var productName: UITextField!
//    @IBOutlet var productImage: UITextField!
//    @IBOutlet var productPrice: UITextField!
//    @IBOutlet var productInfo: UITextField!
    
//    @IBOutlet var showProductInfo: UILabel!
    var city = "Hamilton"
    var product_categories = [String]()
    var products_count = [UInt]()
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
//        let productDB = ref.child(storeName.text!).child("Products")
//        let post = ["StoreName": self.storeName.text!]
        let productDB =  ref.child(city).child(self.storeName.text!).child("Products")
        
       
        
        ref.child(city).child(self.storeName.text!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let productCategories = snapshot.childSnapshot(forPath: "Products").children.allObjects as? [DataSnapshot]{
                self.product_categories = []
                self.products_count = []
                for productCategory in productCategories{
                    self.product_categories.append(productCategory.key)
//                    print(productCategory.childrenCount)
                    self.products_count.append(productCategory.childrenCount)
                    if let products = productCategory.children.allObjects as? [DataSnapshot]{

                        for product in products{
//                            product.setValue(self.storeName.text!, forKey: "productImage_url")
//                            print("........................................")

                        }
                    }
                }
            }
            
        })
        print(self.product_categories)
        print(self.products_count)
//
        var count = 0
        for category in self.product_categories{
//            print(Int(self.products_count[count]))
            
            for i in 0 ... self.products_count[count]-1{
                productDB.child(category).child(String(i)).child("StoreName").setValue(self.storeName.text!)
            }
            count = count+1
        }
//        self.product_categories = []
//        self.products_count = []
//        TODO: Saving values in Database
//        let storeDict = ["Store Location":storeLocation.text!,"Store Image":storeImage.text!]
//        storesDB.setValue(storeDict)
//        let productDict = ["Product Image":productImage.text!, "Product price":productPrice.text!, "Product Info":productInfo.text!]
//        let productDB = storesDB.child(productCategory.text!).child(productName.text!)
//        productDB.setValue(productDict)
        
//        TODO: Updating value
//        productDB.updateChildValues(["Product Info":"not the best laptop"])
        
//         TODO: Reading values from database
//        productDB.child("Product Info").observe(.value) { (snapshot: DataSnapshot) in
//            let snapshotValue = snapshot.value as! String
//            self.showProductInfo.text = snapshotValue
//            
//            
//        }
        
    }
    
}

