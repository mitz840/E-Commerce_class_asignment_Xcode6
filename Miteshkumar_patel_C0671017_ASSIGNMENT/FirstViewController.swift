

import UIKit
import CoreData

var error : NSError?



class FirstViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate {
    
    var managedObjectContext : NSManagedObjectContext!
    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    var name = ""
    var userEmailID = ""
    var quantity = 0
    var phoneIMG = UIImage()
    var watchIMG = UIImage()
    var pictureIMG = UIImage()
    let fetchCellphone = NSFetchRequest(entityName: "Cellphone")
    let fetchSmartwatch = NSFetchRequest(entityName: "Smartwatch")
    let fetchCategory = NSFetchRequest(entityName: "Category")
    
    var imagesPhones = [UIImage(named: "5s"),UIImage(named: "5x"),UIImage(named: "6s"),UIImage(named: "6p"),UIImage(named: "s7edge")]
    var imagesWatch = [UIImage(named: "moto"),UIImage(named: "pebble"),UIImage(named: "Samsung"),UIImage(named: "sony")]
    
   
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        tabBarController!.navigationController?.navigationBarHidden = false

        loadUI()
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        loadItem()
         myTableView.reloadData()
        
        
        
    }
    override func  viewWillAppear(animated: Bool) {
     myTableView.reloadData()
    }
    
    
    func loadUI(){
        myView.backgroundColor = UIColor(patternImage: UIImage(named: "cover")!)
        profileIMG.image = pictureIMG //UIImage(named: "profile")
        profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2
        profileIMG.contentMode = .ScaleToFill
        profileIMG.clipsToBounds = true
        profileIMG.layer.borderWidth = 2
        profileIMG.layer.borderColor = UIColor.whiteColor().CGColor
        nameLBL.text = name
        nameLBL.tintColor = UIColor.whiteColor()
        nameLBL.backgroundColor = UIColor.blueColor()
        nameLBL.layer.borderWidth = 3
        nameLBL.layer.borderColor = UIColor.blackColor().CGColor
        searchBar.delegate = self
        
        if (name.caseInsensitiveCompare("Mitz") == .OrderedSame) {
        
        var addBarBTN = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addItem:")
            tabBarController!.navigationItem.setRightBarButtonItems([addBarBTN], animated: true)
    }
        
    }
    func loadItem(){
        
        
        let resultCategory = managedObjectContext.executeFetchRequest(fetchCategory, error: nil) as? [Category]
        if(resultCategory?.count == 0 ){
            
            let categoryItem = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: self.managedObjectContext) as! Category
            let categoryItem1 = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: self.managedObjectContext) as! Category
            categoryItem1.name = "Phones"
            categoryItem.name = "Smartwatches"
         
            
            let cellphoneItem = NSEntityDescription.insertNewObjectForEntityForName("Cellphone", inManagedObjectContext: self.managedObjectContext) as! Cellphone
            cellphoneItem.model = "BB priv "
            cellphoneItem.about = "secure android"
            cellphoneItem.price = 799.99
            cellphoneItem.quantity = 200
            cellphoneItem.picture = UIImagePNGRepresentation(UIImage(named: "priv"))
            
            let cellphoneItem1 = NSEntityDescription.insertNewObjectForEntityForName("Cellphone", inManagedObjectContext: self.managedObjectContext) as! Cellphone
            cellphoneItem1.model = "Nexus 5x "
            cellphoneItem1.about = "Pure android experience"
            cellphoneItem1.price = 499.99
            cellphoneItem1.quantity = 20
            cellphoneItem1.picture = UIImagePNGRepresentation(UIImage(named: "5x"))
            
            let smartwatchItem = NSEntityDescription.insertNewObjectForEntityForName("Smartwatch", inManagedObjectContext: self.managedObjectContext) as! Smartwatch
            smartwatchItem.model = "Lg Urbane "
            smartwatchItem.about = "urban life"
            smartwatchItem.price = 149.99
            smartwatchItem.quantity = 20
            smartwatchItem.picture = UIImagePNGRepresentation(UIImage(named: "lg"))
            managedObjectContext.save(&error)
            
        }




        
       
    }
    
var numOfSections = 0
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
    let resultCategory = managedObjectContext.executeFetchRequest(fetchCategory, error: nil) as? [Category]
            if searchActive{
                numOfSections = 1
                
            }
            else{
                
                numOfSections =  resultCategory!.count
            }
            return numOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fetchCellphoneResult = managedObjectContext!.executeFetchRequest(fetchCellphone, error: nil) as? [Cellphone]
        let fetchSmartwatchResult = managedObjectContext!.executeFetchRequest(fetchSmartwatch, error: nil) as? [Smartwatch]
        if searchActive{
            return filteredItem.count
        }else{
        if section == 0 {
            return  fetchCellphoneResult!.count
        }else{
            return   fetchSmartwatchResult!.count
        }
    }
    }
    
    var searchCellPhoneArray = [Cellphone] ()
    var searchWatchArray = [Smartwatch] ()

    var mainSearchArray = [AnyObject] ()

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MyCell
        if searchActive{
            cell.modelLBL.text =  filteredItem[indexPath.row].model
            cell.priceLBL.text =  "$" + (filteredItem[indexPath.row].price).stringValue
            cell.quantityLBL.text = (filteredItem[indexPath.row].quantity).stringValue
             cell.modelIMG.image = UIImage(data: filteredItem[indexPath.row].picture)
        }else{
        
        if indexPath.section == 0{
            let randomPhoneImg = Int(arc4random_uniform(UInt32(imagesPhones.count)))
            
            if let fetchCellphoneResult = managedObjectContext!.executeFetchRequest(fetchCellphone, error: nil) as? [Cellphone]{
          
                cell.backgroundColor = UIColor.yellowColor()
                cell.modelLBL.text =  fetchCellphoneResult[indexPath.row].model
                cell.priceLBL.text =   "$" + (fetchCellphoneResult[indexPath.row].price as NSNumber).stringValue
                cell.quantityLBL.text = (fetchCellphoneResult[indexPath.row].quantity as NSNumber).stringValue
                cell.modelIMG.image = UIImage(data: fetchCellphoneResult[indexPath.row].picture)
                
                searchCellPhoneArray.removeAll(keepCapacity: true)
                
                for val in fetchCellphoneResult{
                        searchCellPhoneArray.append(val)
                        
                    
                }
                }
            
            
            
        }else {
           
            let randomWatchImg = Int(arc4random_uniform(UInt32(imagesWatch.count)))


            if let fetchSmartwatchResult = managedObjectContext!.executeFetchRequest(fetchSmartwatch, error: nil) as? [Smartwatch]{
            cell.backgroundColor = UIColor.yellowColor()
            cell.modelLBL.text =  fetchSmartwatchResult[indexPath.row].model
            cell.priceLBL.text =   "$" + (fetchSmartwatchResult[indexPath.row].price as NSNumber).stringValue
            cell.quantityLBL.text = (fetchSmartwatchResult[indexPath.row].quantity as NSNumber).stringValue
            cell.modelIMG.image = UIImage(data: fetchSmartwatchResult[indexPath.row].picture)
               
                searchWatchArray.removeAll(keepCapacity: true)

                
                    for val in fetchSmartwatchResult{
                        searchWatchArray.append(val)
                    }

                    
                
          
            }
            
            
        }
            mainSearchArray.removeAll(keepCapacity: true)

            if let fetchCellphoneResult = managedObjectContext!.executeFetchRequest(fetchCellphone, error: nil) as? [Cellphone]{
                for val in fetchCellphoneResult{
                    mainSearchArray.append(val)
                }}
            if let fetchSmartwatchResult = managedObjectContext!.executeFetchRequest(fetchSmartwatch, error: nil) as? [Smartwatch]{
                for val in fetchSmartwatchResult{
                    mainSearchArray.append(val)
                }}

    }
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var someStr = ""
        let resultCategory = managedObjectContext.executeFetchRequest(fetchCategory, error: nil) as? [Category]
       if let resultCategory = managedObjectContext.executeFetchRequest(fetchCategory, error: nil) as? [Category]{
          someStr =  resultCategory[section].name
        
        }
        return someStr
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.blackColor() //(red: 0/255, green: 181/255, blue: 229/255, alpha: 1.0)
        header.textLabel.textColor = UIColor.whiteColor()
        header.alpha = 0.5     }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let productDetails = storyBoard.instantiateViewControllerWithIdentifier("goToProduct") as? ProductDetails
        
        
        if indexPath.section == 0{
            
            let randomPhoneImg = Int(arc4random_uniform(UInt32(imagesPhones.count)))

            
            if let fetchCellphoneResult = managedObjectContext!.executeFetchRequest(fetchCellphone, error: nil) as? [Cellphone]{

                productDetails?.model = fetchCellphoneResult[indexPath.row].model
                productDetails?.price = (fetchCellphoneResult[indexPath.row].price as NSNumber).stringValue
                productDetails?.desc = fetchCellphoneResult[indexPath.row].about
                productDetails?.modelImg = UIImage(data: fetchCellphoneResult[indexPath.row].picture)!
                productDetails?.userEmailID = userEmailID
                productDetails?.quantity = Int(fetchCellphoneResult[indexPath.row].quantity)

            }
            
            
        }else {
            
            
            let randomWatchImg = Int(arc4random_uniform(UInt32(imagesWatch.count)))

            if let fetchSmartwatchResult = managedObjectContext!.executeFetchRequest(fetchSmartwatch, error: nil) as? [Smartwatch]{
                productDetails?.model = fetchSmartwatchResult[indexPath.row].model
                productDetails?.price = (fetchSmartwatchResult[indexPath.row].price as NSNumber).stringValue
                productDetails?.desc = fetchSmartwatchResult[indexPath.row].about
                productDetails?.modelImg = UIImage(data: fetchSmartwatchResult[indexPath.row].picture)!
                productDetails?.quantity = Int(fetchSmartwatchResult[indexPath.row].quantity)

                productDetails?.userEmailID = userEmailID

            }
            
        }
        self.navigationController?.pushViewController(productDetails!, animated: true)

    }
 
    func addItem(sender : UIBarButtonItem){
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let addItem = storyBoard.instantiateViewControllerWithIdentifier("goToAdd") as! AddItem
        self.navigationController?.pushViewController(addItem, animated: true)
        
    }
    
    var searchActive =  false
    var filteredItem = [AnyObject]()
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text.isEmpty{
            searchActive =  false
            
        }else{
            filteredItem.removeAll(keepCapacity: false)
            for item in mainSearchArray{
               
                let itemName = item.model
                if itemName.lowercaseString.rangeOfString(searchText.lowercaseString) != nil{
                    filteredItem.append(item)
                    self.searchActive = true
                }
                
            }
        }
        self.myTableView.reloadData()
    }
    
    

}