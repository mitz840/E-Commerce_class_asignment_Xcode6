//
//  SecondVC.swift
//  
//
//  Created by Mitesh Patel on 2016-04-02.
//
//

import UIKit
import CoreData

class SecondVC: UIViewController,UITableViewDataSource,UITableViewDelegate ,UISearchBarDelegate{
   
    var managedObjectContext : NSManagedObjectContext!
    let fetchRequest = NSFetchRequest(entityName: "MyCart")
    var userEmailID = ""
    var error : NSError?
    var myCartArray : [MyCart] = []
    var counter = 0
    let RequestCellphone = NSFetchRequest(entityName: "Cellphone")
    let RequestSmartwatch = NSFetchRequest(entityName: "Smartwatch")
    


    @IBOutlet weak var saerchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        saerchBar.delegate = self
        myTableView.dataSource = self
        myTableView.delegate = self
        self.navigationItem.title = "My cart"

        
        
        if let fetchresult = managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as? [MyCart]{
            for val in fetchresult{
                if val.user == userEmailID {

                    myCartArray.append(val)
                }
            }
        }

    }
    
    override func viewWillAppear(animated: Bool) {
       

    myTableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive{
            return filteredItem.count
        }
        else {
            return myCartArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MyCartCell
        if searchActive{
             cell.modelLBL.text = filteredItem[indexPath.row].model
            cell.priceLBL.text = (filteredItem[indexPath.row].price).stringValue
            cell.productIMG.image = UIImage(data: filteredItem[indexPath.row].picture)

            
        }
        else {
        cell.backgroundColor = UIColor.yellowColor()
        cell.modelLBL.text = myCartArray[indexPath.row].model
        cell.priceLBL.text = "$" + (myCartArray[indexPath.row].price).stringValue
        cell.productIMG.image = UIImage(data: myCartArray[indexPath.row].picture)
          
            mainSearchArray.removeAll(keepCapacity: true)
            for val in myCartArray{
                mainSearchArray.append(val)
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{

            
            if let fetchresult = managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as? [MyCart]{
               
                    myCartArray.removeAtIndex(indexPath.row)
                    managedObjectContext.deleteObject(fetchresult[indexPath.row])
                    self.managedObjectContext.save(&self.error)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
              


            }

            
            
        }
        
        
        
        
    }
    var mainSearchArray = [MyCart] ()
    var searchActive =  false
    var filteredItem = [MyCart]()
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
