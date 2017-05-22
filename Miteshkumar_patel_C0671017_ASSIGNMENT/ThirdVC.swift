
import UIKit
import CoreData

class ThirdVC: UIViewController {
    @IBOutlet weak var userNameLBL: UILabel!
    @IBOutlet weak var userNameTXT: UITextField!
    @IBOutlet weak var emailTXT: UITextField!
    @IBOutlet weak var emailLBL: UILabel!
    @IBOutlet weak var passwordTXT: UITextField!
    @IBOutlet weak var passwordLBL: UILabel!
    @IBOutlet weak var confirmPasswordTXT: UITextField!
    @IBOutlet weak var confirmPassLBL: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var profileIMG: UIImageView!
    var managedObjectContext : NSManagedObjectContext!
    var userName = ""
    var email = ""
    var password = ""
    var profileImage = UIImage()
    var addBarBTN :  UIBarButtonItem!
    var error : NSError?


    override func viewDidLoad() {
        super.viewDidLoad()
        managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        loadUI()
        self.navigationItem.title = "Profile"


    }
    func loadUI(){
        confirmPassLBL.hidden = true
        confirmPasswordTXT.hidden = true
        

        userNameTXT.text = userName
        userNameTXT.userInteractionEnabled = false

        emailTXT.text = email
        emailTXT.userInteractionEnabled = false


        passwordTXT.text = password
        passwordTXT.userInteractionEnabled = false
        passwordTXT.secureTextEntry = true

        profileIMG.image = profileImage
        myView.backgroundColor = UIColor(patternImage: UIImage(named: "cover")!)
        profileIMG.layer.cornerRadius = profileIMG.frame.size.width/2
        profileIMG.contentMode = .ScaleToFill
        profileIMG.clipsToBounds = true
        profileIMG.layer.borderWidth = 2
        profileIMG.layer.borderColor = UIColor.whiteColor().CGColor
        
        addBarBTN =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: "editData:")
        tabBarController!.navigationItem.setRightBarButtonItems([addBarBTN], animated: true)
        
        
        
    }
    func editData(sender: UIBarButtonItem){
        
        addBarBTN =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveData:")
        tabBarController!.navigationItem.setRightBarButtonItems([addBarBTN], animated: true)

        
        userNameTXT.userInteractionEnabled = true
        emailTXT.userInteractionEnabled = true
        passwordTXT.userInteractionEnabled = true
        confirmPassLBL.hidden = false
        confirmPasswordTXT.hidden = false
        confirmPasswordTXT.secureTextEntry = true
        
        


        
    }
    func saveData(sender : UIBarButtonItem){
        
        if(!confirmPasswordTXT.text.isEmpty){

        if (confirmPasswordTXT.text == passwordTXT.text){

        let fetchRequest = NSFetchRequest(entityName: "User")
        
        let alert = UIAlertController(title: "Change Request", message: "Do you really want to make changes?", preferredStyle: UIAlertControllerStyle.Alert)
        let yesBTN = UIAlertAction(title: "YES", style: UIAlertActionStyle.Default){
            UIAlertAction in
            if let fetchresult = self.managedObjectContext.executeFetchRequest(fetchRequest, error: nil) as? [User]{
                for val in fetchresult{
                    if val.username == self.userName {
                        val.username = self.userNameTXT.text
                        val.email = self.emailTXT.text
                        val.password = self.passwordTXT.text
                       
                        
                        self.userNameTXT.text = val.username
                        self.userNameTXT.userInteractionEnabled = false
                        self.emailTXT.text = val.email
                        self.emailTXT.userInteractionEnabled = false
                        self.passwordTXT.text = val.password
                        self.passwordTXT.userInteractionEnabled = false
                        self.passwordTXT.secureTextEntry = true
                        self.confirmPassLBL.hidden = true
                        self.confirmPasswordTXT.hidden = true
                        self.managedObjectContext.save(&self.error)
                        self.addBarBTN =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: "editData:")
                        self.tabBarController!.navigationItem.setRightBarButtonItems([self.addBarBTN], animated: true)
                        break
                    }
                }
                
                
                
            }
            
            
        }
            let noBTN = UIAlertAction(title: "NO", style: UIAlertActionStyle.Cancel){
                UIAlertAction in
                self.viewDidLoad()
//                self.userNameTXT.userInteractionEnabled = false
//                self.emailTXT.userInteractionEnabled = false
//                self.passwordTXT.userInteractionEnabled = false
//                self.confirmPassLBL.hidden = true
//                self.confirmPasswordTXT.hidden = true
//                self.addBarBTN =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: "editData:")
//                self.tabBarController!.navigationItem.setRightBarButtonItems([self.addBarBTN], animated: true)
                
            }
            alert.addAction(yesBTN)
            alert.addAction(noBTN)
            self.presentViewController(alert, animated: true, completion: nil)
           
         
           
        }else{
            let alert = UIAlertController(title: "Error", message: "confirm password must be same as password", preferredStyle: UIAlertControllerStyle.Alert)
            let OkBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
                UIAlertAction in
            }
            alert.addAction(OkBTN)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        }
        else{
            let alert = UIAlertController(title: "Error", message: "confirm password must not be empty", preferredStyle: UIAlertControllerStyle.Alert)
            let OkBTN = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel){
                UIAlertAction in
            }
            alert.addAction(OkBTN)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    


    

    

}
