//
//  ViewController.swift
//  sendDataToFirebase
//
//  Created by Prasann Pandya on 2017-08-27.
//  Copyright © 2017 Prasann Pandya. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

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
    var store_address = ""
    var product_categories = [String]()
    var price = [Double]()
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
            self.store_address = snapshot.childSnapshot(forPath: "StoreAddress").value as! String
            if let productCategories = snapshot.childSnapshot(forPath: "Products").children.allObjects as? [DataSnapshot]{
                self.product_categories = []
                self.products_count = []
                self.price = []
                for productCategory in productCategories{
                    self.product_categories.append(productCategory.key)
//                    print(productCategory.childrenCount)
                    self.products_count.append(productCategory.childrenCount)
                    if let products = productCategory.children.allObjects as? [DataSnapshot]{

                        for product in products{
//                            print(product.childSnapshot(forPath: "price"))
                            
                            //TODO: Change price to a double and store it in array
                            if let str = product.childSnapshot(forPath: "price").value as? String{
                                let formatter = NumberFormatter()
                                formatter.numberStyle = .currency
                                
                                let number = formatter.number(from: str)
                                let amount = number?.doubleValue
                                //        print(amount as! Double)
                                self.price.append(amount as! Double)
                                
                            }
                            
                        }
                    }
                }
            }
        })
        
        print(self.product_categories)
        print(self.products_count)
        print(self.price)
        print(self.store_address)
//
        
        var temp = CLGeocoder().geocodeAddressString(self.store_address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    print("No location found")
                    return
            }
            
//            print(location.coordinate.latitude)
//            print(location.coordinate.longitude)
            
            var count = 0
            var j = 0
            for category in self.product_categories{
                //            print(Int(self.products_count[count]))
                
                for i in 0 ... self.products_count[count]-1{
                    j = j+1
//                    print(self.price[j-1])
                    productDB.child(category).child(String(i)).child("StoreName").setValue(self.storeName.text!)
                    productDB.child(category).child(String(i)).child("productCategory").setValue(category)
                    if(self.price.count != 0){
                        productDB.child(category).child(String(i)).child("price").setValue(self.price[j-1])
                    }
                    productDB.child(category).child(String(i)).child("_geoloc").child("lat").setValue(location.coordinate.latitude)
                    productDB.child(category).child(String(i)).child("_geoloc").child("lng").setValue(location.coordinate.longitude)

                }
                count = count+1
            }
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

