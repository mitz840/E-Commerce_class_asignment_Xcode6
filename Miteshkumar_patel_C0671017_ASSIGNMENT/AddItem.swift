//
//  AddItem.swift
//  
//
//  Created by Mitesh Patel on 2016-03-27.
//
//

import UIKit
import CoreData

class AddItem: UIViewController ,UIPickerViewDataSource,UIPickerViewDelegate{
    var availablecategory = ["Cellphones","Smartwatches"]
    
    var imagesPhones = [UIImage(named: "5s"),UIImage(named: "5x"),UIImage(named: "6s"),UIImage(named: "6p"),UIImage(named: "s7edge")]
    var imagesWatch = [UIImage(named: "moto"),UIImage(named: "pebble"),UIImage(named: "Samsung"),UIImage(named: "sony")]

    var managedObjectContext : NSManagedObjectContext!
    var error : NSError?
    
    @IBOutlet weak var myPickerView: UIPickerView!
    @IBOutlet weak var modelTXT: UITextField!
    @IBOutlet weak var descriptionTXT: UITextField!
    @IBOutlet weak var priceTXT: UITextField!
    @IBOutlet weak var quantityTXT: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        myPickerView.dataSource = self
        myPickerView.delegate = self
       // myPickerView.selectedRowInComponent(0)

        
    }
    
    func loadUI(){
        modelTXT.placeholder = "Model"
        descriptionTXT.placeholder = "Description"
        priceTXT.placeholder = "Price"
        quantityTXT.placeholder = "Quantity"
        priceTXT.resignFirstResponder()
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availablecategory.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return availablecategory[row]
    }
    var val = ""
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        val = availablecategory[row]
        
    }
  

    @IBAction func saveAction(sender: UIButton) {
      
        
        if val == "Cellphones" {
            let newItem = NSEntityDescription.insertNewObjectForEntityForName("Cellphone", inManagedObjectContext: self.managedObjectContext!) as! Cellphone
            let randomPhoneImg = Int(arc4random_uniform(UInt32(imagesPhones.count)))

            newItem.model = modelTXT.text
            newItem.about = descriptionTXT.text
            newItem.price = (priceTXT.text as NSString).doubleValue
            newItem.quantity = (quantityTXT.text as NSString).integerValue
            newItem.picture = UIImagePNGRepresentation(imagesPhones[randomPhoneImg])
            
            managedObjectContext.save(&error)
     
            
        }
        if val == "Smartwatches"{
            let newItem = NSEntityDescription.insertNewObjectForEntityForName("Smartwatch", inManagedObjectContext: self.managedObjectContext!) as! Smartwatch
            let randomWatchImg = Int(arc4random_uniform(UInt32(imagesWatch.count)))

            newItem.model = modelTXT.text
            newItem.about = descriptionTXT.text
            newItem.price = (priceTXT.text as NSString).doubleValue
            newItem.quantity = (quantityTXT.text as NSString).integerValue
            newItem.picture = UIImagePNGRepresentation(imagesWatch[randomWatchImg])
            managedObjectContext.save(&error)

            
            
        }
        let alert = UIAlertController(title: "Message", message: "Item added successfully", preferredStyle: UIAlertControllerStyle.Alert)
        let okBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){
            UIAlertAction in
            self.modelTXT.text = ""
            self.descriptionTXT.text = ""
            self.priceTXT.text = ""
            self.quantityTXT.text = ""
            
            
        }
        alert.addAction(okBTN)
        self.presentViewController(alert, animated: true, completion: nil)
    }
   
}
