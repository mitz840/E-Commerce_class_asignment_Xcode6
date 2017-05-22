//
//  ViewController.swift
//  Miteshkumar_patel_C0671017_ASSIGNMENT
//
//  Created by Mitesh Patel on 2016-03-25.
//  Copyright (c) 2016 Miteshkumar Patel. All rights reserved.
//

import UIKit
import CoreData

class Home: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    var managedObjectContext : NSManagedObjectContext!
    
   
   let fetchUserRequest = NSFetchRequest(entityName: "User")

 
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "navigation")
        imageView.image = image
        navigationItem.titleView = imageView
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        
        
        let user = managedObjectContext.executeFetchRequest(fetchUserRequest, error: nil) as? [User]
        if user?.count == 0{
            let admin = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: self.managedObjectContext) as! User
            let user1 = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: self.managedObjectContext) as! User
        
        admin.username = "Mitz"
        admin.email = "admin"
        admin.password = "admin"
        admin.picture = UIImageJPEGRepresentation(UIImage(named: "Mitz_TTC"),1)
        
        user1.username = "vishal"
        user1.email = "1"
        user1.password = "1"
        user1.picture = UIImageJPEGRepresentation(UIImage(named: "vishal"), 1)
        managedObjectContext.save(&error)

    }
       
        
        
    }
    
    override func  viewWillAppear(animated: Bool) {
       self.view.reloadInputViews()
        self.navigationController?.navigationBarHidden = true
    }
    
    func loadUI(){
        
        userNameTextField.placeholder = "Enter User Email_ID"
        passwordTextField.placeholder = "Enter Password"
        passwordTextField.secureTextEntry = true
        
    }
   
    
    
    
    
    
    @IBAction func loginAction(sender: UIButton) {
        let fetchrequest = NSFetchRequest(entityName: "User")
        
        if(userNameTextField.text.isEmpty || passwordTextField.text.isEmpty){
           
            if(userNameTextField.text.isEmpty && passwordTextField.text.isEmpty){
                let alert = UIAlertController(title: "Login Error", message: "Username and Password can not be empty!!", preferredStyle: .Alert)
                var okBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
                    UIAlertAction in
                }
                alert.addAction(okBTN)
                self.presentViewController(alert, animated: true, completion: nil)
            }
                
            else if (userNameTextField.text.isEmpty){
                let alert = UIAlertController(title: "Login Error", message: "Username can't be  empty!!", preferredStyle: .Alert)
                var okBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
                    UIAlertAction in
                }
                alert.addAction(okBTN)
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
            else if(passwordTextField.text.isEmpty){
                
                let alert = UIAlertController(title: "Login Error", message: "Password can't be Empty!!", preferredStyle: .Alert)
                var okBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
                    UIAlertAction in
                }
                alert.addAction(okBTN)
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
        }
            
        else if (!userNameTextField.text.isEmpty && !passwordTextField.text.isEmpty){
            
            if let fetchResult = managedObjectContext!.executeFetchRequest(fetchrequest, error: nil) as? [User]
            {

                var wrongpass = true
                var wrongUserName = true

                
                for(var i = 0 ; i <  fetchResult.count ; i++){

                    var userEmailID =  fetchResult[i].email
                    var userPassword =  fetchResult[i].password
                    var userName = fetchResult[i].username
                    var userPicture : UIImage  = UIImage(data: fetchResult[i].picture)!
                    
                    
                    
                    if ( userNameTextField.text.caseInsensitiveCompare(userEmailID) == .OrderedSame && passwordTextField.text == userPassword){
                       
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let welcome : UITabBarController = storyBoard.instantiateViewControllerWithIdentifier("goToTab") as! UITabBarController
                        let firstVC : FirstViewController = welcome.viewControllers?.first as! FirstViewController
                        firstVC.name = userName
                        firstVC.pictureIMG = userPicture
                        firstVC.userEmailID = userEmailID
                        
                        var secondVC = welcome.viewControllers![1] as! SecondVC
                        secondVC.userEmailID = userEmailID
                        
                        var thirdVC  = welcome.viewControllers![2] as! ThirdVC
                        thirdVC.userName = userName
                        thirdVC.email = userEmailID
                        thirdVC.password = userPassword
                        thirdVC.profileImage = userPicture
                        
//                        let productOwner = storyBoard.instantiateViewControllerWithIdentifier("goToProduct") as! ProductDetails
//                        productOwner.userEmailID = userEmailID
                        
                        
                        self.navigationController!.pushViewController(welcome, animated: true)
                        wrongpass = false
                        wrongUserName = false
                        

                        break
                        
                    }
                    else if (userNameTextField.text.lowercaseString ==  userEmailID.lowercaseString && passwordTextField.text != userPassword){

                        wrongpass = true
                        wrongUserName = false
                        break
                        
                    }
                    else if (userNameTextField.text.lowercaseString !=  userEmailID.lowercaseString ){
                        wrongUserName = true
                        wrongpass = true
                       

                        
                        
                    }
                    
                }
                

                if (wrongUserName == false && wrongpass == true){
                    let alert = UIAlertController(title: "Login Error", message: "Wrong  Password", preferredStyle: .Alert)
                                        var okBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
                                           UIAlertAction in
                                          self.passwordTextField.text = ""
                                        }
                                        alert.addAction(okBTN)
                                       self.presentViewController(alert, animated: true, completion: nil)
                    
                }else if(wrongUserName == true ){
                    let alert = UIAlertController(title: "Login Error", message: "User Not Exist", preferredStyle: .Alert)
                    var okBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
                        UIAlertAction in
                   //self.userNameTextField.text = ""
                    }
                    alert.addAction(okBTN)
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
            }
            
        }
        

}

    @IBAction func registerAction(sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let register : Register = storyBoard.instantiateViewControllerWithIdentifier("goToRegister") as! Register
        self.navigationController?.pushViewController(register, animated: true)
    }

}


