//
//  IALoginViewController.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 30/10/2017.
//

import UIKit

class IALoginViewController: UIViewController {
    
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    @IBAction func btnLogin(_ sender: Any) {
        
        if (txtUsername.text?.isEmpty)!||(txtPassword.text?.isEmpty)!{
            
            showAlert()
            
        }else{
            
            //TODO login
            
            
        }
        
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
