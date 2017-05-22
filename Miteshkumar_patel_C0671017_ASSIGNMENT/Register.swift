//
//  Register.swift
//  
//
//  Created by Mitesh Patel on 2016-03-25.
//
//

import UIKit
import CoreData

class Register: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reTypeTextField: UITextField!
    let fetchUser = NSFetchRequest(entityName: "User")

    var error : NSError?
    var pictureArray = [UIImage(named: "abhi"),UIImage(named: "isan1"),UIImage(named: "jigar"),UIImage(named: "sonu1"),UIImage(named: "Brothers")]
    
    var managedObjectContext : NSManagedObjectContext!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.title = "Register"

        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    }
    
    

    func loadUI(){
        usernameTextField.placeholder = "Enter Username"
        emailTextField.placeholder = "Enter E-mail ID"
        passwordTextField.placeholder = "Enter password"
        reTypeTextField.placeholder = "Confirm password"
        passwordTextField.secureTextEntry = true
        reTypeTextField.secureTextEntry = true
    }
    
    @IBAction func registerAction(sender: UIButton) {
        if (usernameTextField.text.isEmpty || emailTextField.text.isEmpty || passwordTextField.text.isEmpty || reTypeTextField.text.isEmpty){
            if(reTypeTextField.text.isEmpty){
                let alert = UIAlertController(title: "Error", message: "Confirm Password must be empty", preferredStyle: .Alert)
                var okBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
                    UIAlertAction in
                }
                alert.addAction(okBTN)
                self.presentViewController(alert, animated: true, completion: nil)
            }
                
            else if (usernameTextField.text.isEmpty){
                let alert = UIAlertController(title: "Error", message: "Username can't be empty", preferredStyle: UIAlertControllerStyle.Alert)
                
                var okBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
                    UIAlertAction in
                }
                alert.addAction(okBTN)
                self.presentViewController(alert, animated: true, completion: nil)
            }
                
            else if(emailTextField.text.isEmpty){
                let alert = UIAlertController(title: "Error", message: "E-mail can't be empty", preferredStyle: UIAlertControllerStyle.Alert)
                var okBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
                    UIAlertAction in
                }
                alert.addAction(okBTN)
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
                
            else if (passwordTextField.text.isEmpty){
                let alert = UIAlertController(title: "Error", message: "Password can't be empty", preferredStyle: UIAlertControllerStyle.Alert)
                
                var okBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
                    UIAlertAction in
                }
                alert.addAction(okBTN)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }else if(passwordTextField.text !=  reTypeTextField.text){
          
            let alert = UIAlertController(title: "Error", message: "Confirm Password must be same as password", preferredStyle: .Alert)
            var okBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
                UIAlertAction in
            }
            alert.addAction(okBTN)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }  else {
            var bool = false
            if let fetchResultUser = managedObjectContext.executeFetchRequest(fetchUser, error: nil) as? [User]{
                for val in fetchResultUser{
                    if (emailTextField.text.lowercaseString == val.email.lowercaseString){
                        let alert = UIAlertController(title: "Error", message: "E-mail already registered,try different E-mail ID", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        var okBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
                            UIAlertAction in
                            self.emailTextField.text = ""
                            
                            
                        }
                        alert.addAction(okBTN)
                        self.presentViewController(alert, animated: true, completion: nil)
                        bool = false
                        break
                     
                    }else{
                        bool = true
                        
                    }
                    
                }
                if bool{
                    let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: self.managedObjectContext) as! User
                    let fetchRequest = NSFetchRequest(entityName: "User")
                    let randomImg = Int(arc4random_uniform(UInt32(pictureArray.count)))

                    
                    newUser.username = usernameTextField.text
                    newUser.email = emailTextField.text
                    newUser.password = passwordTextField.text
                    newUser.picture = UIImageJPEGRepresentation(pictureArray[randomImg], 0.5) //UIImagePNGRepresentation(pictureArray[randomImg])
                    managedObjectContext.save(&error)
                    
                    
                    
                    let alert = UIAlertController(title: "Success", message: "User created successfully", preferredStyle: UIAlertControllerStyle.Alert)
                    let okBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){
                        UIAlertAction in
                        
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let home : Home = storyBoard.instantiateViewControllerWithIdentifier("goToHome") as! Home
                        self.navigationController?.pushViewController(home, animated: true)
                        
                    }
                    alert.addAction(okBTN)
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
                
            }
            
        }
            
    }
}
