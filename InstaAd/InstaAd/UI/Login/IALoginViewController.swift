//
//  IALoginViewController.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 30/10/2017.
//

import UIKit
import FirebaseAuth

class IALoginViewController: UIViewController {
    
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    @IBAction func btnLogin(_ sender: Any) {
        
        if (txtUsername.text?.isEmpty)!||(txtPassword.text?.isEmpty)!{
            
            showAlert()
            
        }else{
            
            Auth.auth().signIn(withEmail: txtUsername.text!, password: txtPassword.text!) { (user, error) in
                
                if error == nil {
                    //TODO - izbriši nakon redirekcije na stranicu početnu
                    let alertController = UIAlertController(title: "Login good", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    //TODO - otkomentiraj kad ce bit prebacivanje na glavnu stranicu
                    //Go to the HomeViewController if the login is sucessful
                    //let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    //self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
            
        }
        
    }
    
    @IBAction func btnCreateNewAccountClicked(_ sender: UIButton) {
        
    UIApplication.shared.keyWindow?.rootViewController?.present(IARegistrationViewController(), animated: true, completion: nil)
        
    }
    func showAlert() {
        let alertController = UIAlertController(title: "Error", message: "Enter both username and password", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
