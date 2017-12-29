//
//  IASettingsViewController.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 20/11/2017.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class IASettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    @IBOutlet weak var tableView: UITableView!
    var databaseReference : DatabaseReference!;
    var databaseUserName = "";

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none;

        fetchEvents();
        self.tableView.reloadData();

        tableView.register(UINib (nibName: "IASettingsUserDataTableViewCell", bundle: nil), forCellReuseIdentifier: "IASettingsUserDataTableViewCell");
        tableView.register(UINib (nibName: "IASettingsButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "IASettingsButtonTableViewCell");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50;
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section
        {
        case 0:
            return "User profile";
        case 1:
            return "Change password";
        case 2:
            return "Additional options";
        default:
            return "";
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            return 4;
        case 1:
            return 4;
        default:
            return 1;
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0)
        {
            let user = Auth.auth().currentUser;
            databaseReference = Database.database().reference();

            if (indexPath.row == 0)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IASettingsUserDataTableViewCell", for: indexPath) as! IASettingsUserDataTableViewCell;
                cell.lblUserDataLabel.text = "Email";
                editSettingsUserDataTableViewCell(cell: cell);
                cell.txtUserDataValue.text = user?.email;
                cell.txtUserDataValue.isEnabled = false;
                return cell;
            }
            else if (indexPath.row == 1)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IASettingsUserDataTableViewCell", for: indexPath) as! IASettingsUserDataTableViewCell;
                cell.lblUserDataLabel.text = "Registration date";
                editSettingsUserDataTableViewCell(cell: cell);

                var result = "";
                let dateOfRegistration = user?.metadata.creationDate?.description;
                if let start = dateOfRegistration?.index((dateOfRegistration?.startIndex)!, offsetBy: 0), let end = dateOfRegistration?.index((dateOfRegistration?.endIndex)!, offsetBy: -5){
                    result = String(dateOfRegistration![start..<end])
                }

                cell.txtUserDataValue.text = result;
                cell.txtUserDataValue.isEnabled = false;
                return cell;
            }
            else if (indexPath.row == 2)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IASettingsUserDataTableViewCell", for: indexPath) as! IASettingsUserDataTableViewCell;
                cell.lblUserDataLabel.text = "Name";
                editSettingsUserDataTableViewCell(cell: cell);
                cell.txtUserDataValue.text = databaseUserName;
                cell.txtUserDataValue.delegate = self;
                return cell;
            }
            else{
                let aCell = tableView.dequeueReusableCell(withIdentifier: "IASettingsButtonTableViewCell", for: indexPath) as! IASettingsButtonTableViewCell;
                aCell.btnSettingsButton.setTitle("Save username", for: UIControlState.normal);
                aCell.btnSettingsButton.backgroundColor = UIColor (red: 30/255, green: 144/255, blue: 255/255, alpha: 1);
                aCell.btnSettingsButton.tintColor = UIColor .black;
                editSettingsButtonTableViewCell(cell: aCell);

                aCell.btnSettingsButton.tag = indexPath.section;
                aCell.btnSettingsButton.addTarget(self,action:#selector(settingsButtonClicked(sender:)), for: .touchUpInside);
                return aCell;
            }
        }
        else if (indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IASettingsUserDataTableViewCell", for: indexPath) as! IASettingsUserDataTableViewCell;
                cell.lblUserDataLabel.text = "Current password";
                editSettingsUserDataTableViewCell(cell: cell);
                cell.txtUserDataValue.delegate = self;
                return cell;
            }
            else if (indexPath.row == 1)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IASettingsUserDataTableViewCell", for: indexPath) as! IASettingsUserDataTableViewCell;
                cell.lblUserDataLabel.text = "New password";
                editSettingsUserDataTableViewCell(cell: cell);
                cell.txtUserDataValue.delegate = self;
                return cell;
            }
            else if (indexPath.row == 2)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IASettingsUserDataTableViewCell", for: indexPath) as! IASettingsUserDataTableViewCell;
                cell.lblUserDataLabel.text = "Repeat password";
                editSettingsUserDataTableViewCell(cell: cell);
                cell.txtUserDataValue.delegate = self;
                return cell;
            }
            else
            {
                let aCell = tableView.dequeueReusableCell(withIdentifier: "IASettingsButtonTableViewCell", for: indexPath) as! IASettingsButtonTableViewCell;
                aCell.btnSettingsButton.setTitle("Save password", for: UIControlState.normal);
                aCell.btnSettingsButton.backgroundColor = UIColor (red: 30/255, green: 144/255, blue: 255/255, alpha: 1);
                aCell.btnSettingsButton.tintColor = UIColor .black;
                editSettingsButtonTableViewCell(cell: aCell);

                aCell.btnSettingsButton.tag = indexPath.section;
                aCell.btnSettingsButton.addTarget(self,action:#selector(settingsButtonClicked(sender:)), for: .touchUpInside);
                return aCell;
            }
        }
        else
        {
            let aCell = tableView.dequeueReusableCell(withIdentifier: "IASettingsButtonTableViewCell", for: indexPath) as! IASettingsButtonTableViewCell;
            aCell.btnSettingsButton.setTitle("Logout", for: UIControlState.normal);
            aCell.btnSettingsButton.backgroundColor = UIColor (red: 220/255, green: 20/255, blue: 60/255, alpha: 1);
            aCell.btnSettingsButton.tintColor = UIColor .black;
            editSettingsButtonTableViewCell(cell: aCell);

            aCell.btnSettingsButton.tag = indexPath.section;
            aCell.btnSettingsButton.addTarget(self,action:#selector(settingsButtonClicked(sender:)), for: .touchUpInside);
            return aCell;
        }
    }

    func editSettingsUserDataTableViewCell(cell: IASettingsUserDataTableViewCell) -> Void {
        cell.txtUserDataValue.text = "";
        cell.txtUserDataValue.layer.borderWidth = 1;
        cell.txtUserDataValue.layer.cornerRadius = 5;
        cell.txtUserDataValue.layer.borderColor = UIColor.black.cgColor;
    }

    func editSettingsButtonTableViewCell(cell: IASettingsButtonTableViewCell) -> Void {
        let shiftX = (cell.frame.width - cell.btnSettingsButton.frame.width) / 2;
        let shiftY = (cell.btnSettingsButton.frame.height - 40) / 2;
        cell.btnSettingsButton.frame = CGRect (x: shiftX, y: shiftY, width: cell.btnSettingsButton.frame.width, height: 40);
        cell.btnSettingsButton.layer.cornerRadius = 5;
        cell.btnSettingsButton.layer.borderWidth = 2;
    }

    @objc func settingsButtonClicked(sender:UIButton){
        let buttonSection  = sender.tag;
        NSLog("Odabrani gumb: ");
        NSLog(String(buttonSection));
        switch buttonSection {
        case 0:
            changeUserName();
            break;
        case 1:
            changeUserPassword();
            break;
        case 2:
            logout();
            break;
        default:
            NSLog("Unknown selection");
        }
    }

    func changeUserName() -> Void {
        let cellUserName = self.tableView.cellForRow(at: IndexPath (row: 2, section: 0)) as! IASettingsUserDataTableViewCell;
        let userName = cellUserName.txtUserDataValue.text;

        let user = Auth.auth().currentUser;
        databaseReference = Database.database().reference();
        let userDatabaseReference = databaseReference.child("users").child((user?.uid)!).child("name");
        userDatabaseReference.setValue(userName);
        databaseUserName = userName!;
        showAlertViewController(title: "Name changed", message: "Successfully changed name");
    }

    func changeUserPassword() -> Void {
        let cellCurrentPassword = self.tableView.cellForRow(at: IndexPath (row: 0, section: 1)) as! IASettingsUserDataTableViewCell;
        let cellNewPassword = self.tableView.cellForRow(at: IndexPath (row: 1, section: 1)) as! IASettingsUserDataTableViewCell;
        let cellRepeatPassword = self.tableView.cellForRow(at: IndexPath (row: 2, section: 1)) as! IASettingsUserDataTableViewCell;

        let currentPassword = cellCurrentPassword.txtUserDataValue.text;
        let newPassword = cellNewPassword.txtUserDataValue.text;
        let repeatPassword = cellRepeatPassword.txtUserDataValue.text;

        if (validationPassword(enteredPassword: newPassword!))
        {
            if (newPassword == repeatPassword && newPassword != "")
            {
                let user = Auth.auth().currentUser;
                let credential : AuthCredential;
                credential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: currentPassword!);

                user?.reauthenticate(with: credential, completion: { (error) in
                    if (error != nil)
                    {
                        NSLog("Pogreška prilikom reuatentificiranja korisnika");
                        self.showAlertViewController(title: "Error", message: "We occured error while trying reautheticate user. Please try again");
                    }
                    else
                    {
                        user?.updatePassword(to: newPassword!, completion: { (error) in
                            if (error != nil)
                            {
                                NSLog("Dogodila se pogreška prilikom ažuriranja lozinke");
                                self.showAlertViewController(title: "Error", message: "We occured error while trying to update password. Please try again");
                            }
                            else
                            {
                                NSLog("Uspješno ažurirana lozinka");
                                self.showAlertViewController(title: "Password change", message: "Password has been changed successfully");
                            }
                        })
                    }
                })
            }
            else{
                self.showAlertViewController(title: "Error", message: "New password and repeated password are not equal");
            }
        }
        else
        {
            NSLog("Format unesene nove lozinke nije valjan");
            self.showAlertViewController(title: "Error", message: "Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 number and must be at least 8 characters long!")
        }

        cellCurrentPassword.txtUserDataValue.text = "";
        cellNewPassword.txtUserDataValue.text = "";
        cellRepeatPassword.txtUserDataValue.text = "";
    }

    func logout() -> Void {
        do
        {
            try Auth.auth().signOut();
            let appde = UIApplication.shared.delegate as! AppDelegate;
            appde.showNavigation(action: "logout");
        }
        catch let error as NSError
        {
            NSLog("Dogodila se pogreška prilikom odjavljivanja korisnika iz aplikacije: ");
            NSLog(error.localizedDescription);
        }
    }

    //method for fetching values from database
    func fetchEvents() -> Void {
        let user = Auth.auth().currentUser;
        databaseReference = Database.database().reference();
        databaseReference = databaseReference.child("users").child((user?.uid)!).child("name");

        databaseReference.observe(.value, with: { (snapshot) in
            self.databaseUserName = (snapshot.value as? String)!;
            self.tableView.reloadData();
        });
    }

    func showAlertViewController(title: String, message: String) -> Void {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil);
        alertController.addAction(okAction);

        self.present(alertController, animated: true, completion: nil);
    }

    //password validation function (1 uppercase, 1 lowercase, 1 number, min. 8 characters)
    func validationPassword(enteredPassword : String) -> Bool {
        var returnValue = true;
        let passwordRegex = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}";

        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex);
        returnValue = passwordTest.evaluate(with: enteredPassword);

        return returnValue;
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
}
