//
//  IARegistrationViewController.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 30/10/2017.
//

import UIKit
import FirebaseAuth

class IARegistrationViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRepeatPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: Action methods

    //action when Back button is pressed
    @IBAction func backButtonPressed(_ sender: UIButton) {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil);
    }

    //action when Register button is pressed
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if (isRegistrationOk())
        {
            NSLog("Svi podaci kod registracije su uspješno uneseni");

            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!, completion: {(user, error) in
                if (user != nil)
                {
                    NSLog("Korisnik je uspješno registriran");
                    UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil);
                }
                else
                {
                    self.displayAlert(messageToDisplay: "Email je već zauzet!");
                }
            })
        }
        else
        {
            NSLog("Registracija neuspješna");
        }
    }

    //MARK: Validation methods

    //function to check if all input fields are entered
    func isAllFieldsEntered(enteredEmail : String, enteredPassword : String, enteredRepeatPassword : String) -> Bool {
        var returnValue = true;

        if (enteredEmail.count == 0 || enteredPassword.count == 0 || enteredRepeatPassword.count == 0)
        {
            returnValue = false;
        }

        return returnValue;
    }

    func isRegistrationOk() -> Bool {
        var returnValue = true;

        if (!isAllFieldsEntered(enteredEmail: txtEmail.text!, enteredPassword: txtPassword.text!, enteredRepeatPassword: txtRepeatPassword.text!))
        {
            returnValue = false;
            displayAlert(messageToDisplay: "All fields are required!");
        }
        else if (!validationEmail(enteredEmail: txtEmail.text!))
        {
            returnValue = false;
            displayAlert(messageToDisplay: "Entered email is not valid");
        }
        else if (!validationPassword(enteredPassword: txtPassword.text!))
        {
            returnValue = false;
            displayAlert(messageToDisplay: "Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 number and must be at least 8 characters long!");
        }
        else if (!isRepeatPasswordEqualsPassword(enteredPassword: txtPassword.text!, enteredRepeatPassword: txtRepeatPassword.text!))
        {
            returnValue = false;
            displayAlert(messageToDisplay: "Both psswords must be equal!");
        }

        return returnValue;
    }

    //function to check if password and repeat password are equal
    func isRepeatPasswordEqualsPassword(enteredPassword : String, enteredRepeatPassword : String) -> Bool {
        var returnValue = true;

        if (!enteredRepeatPassword.elementsEqual(enteredPassword))
        {
            returnValue = false;
        }

        return returnValue;
    }

    //email validation function
    func validationEmail(enteredEmail : String) -> Bool {
        var returnValue = true;
        let emailRegex = "[A-Za-z0-9.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}";

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex);
        returnValue = emailTest.evaluate(with: enteredEmail);

        return returnValue;
    }

    //password validation function (1 uppercase, 1 lowercase, 1 number, min. 8 characters)
    func validationPassword(enteredPassword : String) -> Bool {
        var returnValue = true;
        let passwordRegex = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}";

        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex);
        returnValue = passwordTest.evaluate(with: enteredPassword);

        return returnValue;
    }

    //MARK: Alert display function
    func displayAlert(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Error", message: messageToDisplay, preferredStyle: .alert);
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil);
        alertController.addAction(okAction);

        self.present(alertController, animated: true, completion: nil);
    }
}
