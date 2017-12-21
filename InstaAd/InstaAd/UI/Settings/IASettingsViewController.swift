//
//  IASettingsViewController.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 20/11/2017.
//

import UIKit
import FirebaseAuth

class IASettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib (nibName: "IASettingsUserDataTableViewCell", bundle: nil), forCellReuseIdentifier: "IASettingsUserDataTableViewCell");
        tableView.register(UINib (nibName: "IASettingsButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "IASettingsButtonTableViewCell");

        view.backgroundColor = UIColor .green;
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
            if (indexPath.row == 0)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IASettingsUserDataTableViewCell", for: indexPath) as! IASettingsUserDataTableViewCell;
                cell.lblUserDataLabel.text = "Email";
                editSettingsUserDataTableViewCell(cell: cell);
                cell.txtUserDataValue.text = "user email from firebase";
                cell.txtUserDataValue.isEnabled = false;
                return cell;
            }
            else if (indexPath.row == 1)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IASettingsUserDataTableViewCell", for: indexPath) as! IASettingsUserDataTableViewCell;
                cell.lblUserDataLabel.text = "Registration date";
                editSettingsUserDataTableViewCell(cell: cell);
                cell.txtUserDataValue.text = "Date of registration from firebase";
                cell.txtUserDataValue.isEnabled = false;
                return cell;
            }
            else if (indexPath.row == 2)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IASettingsUserDataTableViewCell", for: indexPath) as! IASettingsUserDataTableViewCell;
                cell.lblUserDataLabel.text = "Username";
                editSettingsUserDataTableViewCell(cell: cell);
                return cell;
            }
            else{
                let aCell = tableView.dequeueReusableCell(withIdentifier: "IASettingsButtonTableViewCell", for: indexPath) as! IASettingsButtonTableViewCell;
                aCell.btnSettingsButton.setTitle("Save username", for: UIControlState.normal);
                aCell.btnSettingsButton.backgroundColor = UIColor .green;
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
                return cell;
            }
            else if (indexPath.row == 1)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IASettingsUserDataTableViewCell", for: indexPath) as! IASettingsUserDataTableViewCell;
                cell.lblUserDataLabel.text = "New password";
                editSettingsUserDataTableViewCell(cell: cell);
                return cell;
            }
            else if (indexPath.row == 2)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IASettingsUserDataTableViewCell", for: indexPath) as! IASettingsUserDataTableViewCell;
                cell.lblUserDataLabel.text = "Repeat password";
                editSettingsUserDataTableViewCell(cell: cell);
                return cell;
            }
            else
            {
                let aCell = tableView.dequeueReusableCell(withIdentifier: "IASettingsButtonTableViewCell", for: indexPath) as! IASettingsButtonTableViewCell;
                aCell.btnSettingsButton.setTitle("Save password", for: UIControlState.normal);
                aCell.btnSettingsButton.backgroundColor = UIColor .green;
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
            aCell.btnSettingsButton.backgroundColor = UIColor .red;
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
        NSLog("Method for changing user name in database");
    }

    func changeUserPassword() -> Void {
        let cellCurrentPassword = self.tableView.cellForRow(at: IndexPath (row: 0, section: 1)) as! IASettingsUserDataTableViewCell;
        let cellNewPassword = self.tableView.cellForRow(at: IndexPath (row: 1, section: 1)) as! IASettingsUserDataTableViewCell;
        let cellRepeatPassword = self.tableView.cellForRow(at: IndexPath (row: 2, section: 1)) as! IASettingsUserDataTableViewCell;

        let currentPassword = cellCurrentPassword.txtUserDataValue.text;
        let newPassword = cellNewPassword.txtUserDataValue.text;
        let repeatPassword = cellRepeatPassword.txtUserDataValue.text;

        if (newPassword == repeatPassword && newPassword != "")
        {
            let user = Auth.auth().currentUser;
            let credential : AuthCredential;
            credential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: currentPassword!);

            user?.reauthenticate(with: credential, completion: { (error) in
                if (error != nil)
                {
                    NSLog("Pogreška prilikom reuatentificiranja korisnika");
                }
                else
                {
                    user?.updatePassword(to: newPassword!, completion: { (error) in
                        if (error != nil)
                        {
                            NSLog("Dogodila se pogreška prilikom ažuriranja lozinke");
                        }
                        else
                        {
                            NSLog("Uspješno ažurirana lozinka");
                        }
                    })
                }
            })
        }
        else{
            //TODO add alert message
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
}
