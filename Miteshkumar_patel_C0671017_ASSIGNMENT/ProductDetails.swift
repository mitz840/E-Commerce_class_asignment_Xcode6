import UIKit
import CoreData

class ProductDetails: UIViewController {
    var error : NSError?

    @IBOutlet weak var descDataLBL: UILabel!
    @IBOutlet weak var priceDataLBL: UILabel!
    @IBOutlet weak var ModelDataLBL: UILabel!
    @IBOutlet weak var descriptionLBL: UILabel!
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var modelLBL: UILabel!
    @IBOutlet weak var headerLBL: UILabel!
    @IBOutlet weak var productIMG: UIImageView!
    var managedObjectContext : NSManagedObjectContext!
    var model = ""
    var price = ""
    var desc = ""
    var userEmailID = ""
    var quantity = 0
    var modelImg = UIImage()
    let RequestCellphone = NSFetchRequest(entityName: "Cellphone")
    let RequestSmartwatch = NSFetchRequest(entityName: "Smartwatch")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        loadUI()


    }
    func loadUI(){
        
        var addBarBTN = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addToCart:")
        self.navigationItem.setRightBarButtonItems([addBarBTN], animated: true)
        
        ModelDataLBL.text = model
        priceDataLBL.text = price
        descDataLBL.text = desc
        productIMG.image = modelImg
     
    }
    func addToCart(sender : UIBarButtonItem){
       

    if quantity > 0 {
        println(quantity)
        
        let alert = UIAlertController(title: "Message", message: "Add to your cart?", preferredStyle: UIAlertControllerStyle.Alert)
        var yesBTN = UIAlertAction(title: "YES", style: UIAlertActionStyle.Default){
            UIAlertAction in
            var cartItem = NSEntityDescription.insertNewObjectForEntityForName("MyCart", inManagedObjectContext: self.managedObjectContext) as! MyCart
            cartItem.model = self.model
            cartItem.price = (self.price as NSString).doubleValue
            cartItem.picture = UIImageJPEGRepresentation(self.modelImg, 0.5)
            cartItem.user = self.userEmailID
            cartItem.quantity = 1
            if let resultCellphone = self.managedObjectContext.executeFetchRequest(self.RequestCellphone, error: nil) as? [Cellphone]{
            for val in resultCellphone{
                    if val.model == self.model{
                        val.quantity = (val.quantity as NSNumber).integerValue - (cartItem.quantity as NSNumber).integerValue
                    }
                }
                
            }
            if let resultSmartwatch = self.managedObjectContext.executeFetchRequest(self.RequestSmartwatch, error: nil) as? [Smartwatch]{
                    for val in resultSmartwatch{
                        if val.model == self.model{
                            val.quantity = (val.quantity as NSNumber).integerValue - (cartItem.quantity as NSNumber).integerValue
                        }
                    }
                }
            
            self.managedObjectContext.save(&self.error)
            
            

        }
        var noBTN = UIAlertAction(title: "NO", style: UIAlertActionStyle.Cancel){
            UIAlertAction in
        }
        alert.addAction(yesBTN)
        alert.addAction(noBTN)
        self.presentViewController(alert, animated: true, completion: nil)
        
        }
        else{
            let alert = UIAlertController(title: "Item Out of stock", message: "\(quantity) Items are available", preferredStyle: UIAlertControllerStyle.Alert)
            var okBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
                UIAlertAction in
            }
            alert.addAction(okBTN)
            self.presentViewController(alert, animated: true, completion: nil)

            
        }
    }

}
