//
//  IASettingsViewController.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 20/11/2017.
//

import UIKit

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
            return 2;
        case 1:
            return 3;
        default:
            return 1;
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IASettingsUserDataTableViewCell", for: indexPath) as! IASettingsUserDataTableViewCell;
            if (indexPath.row == 0)
            {
                cell.lblUserDataLabel.text = "Email";
                cell.txtUserDataValue.text = "user email from firebase";
                cell.txtUserDataValue.isEnabled = false;
            }
            else
            {
                cell.lblUserDataLabel.text = "Registration date";
                cell.txtUserDataValue.text = "Date of registration from firebase";
                cell.txtUserDataValue.isEnabled = false;
            }
            return cell;
        }
        else if (indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IASettingsUserDataTableViewCell", for: indexPath) as! IASettingsUserDataTableViewCell;
                cell.lblUserDataLabel.text = "New password";
                cell.txtUserDataValue.text = "";
                return cell;
            }
            else if (indexPath.row == 1)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "IASettingsUserDataTableViewCell", for: indexPath) as! IASettingsUserDataTableViewCell;
                cell.lblUserDataLabel.text = "Repeat password";
                cell.txtUserDataValue.text = "";
                return cell;
            }
            else
            {
                let aCell = tableView.dequeueReusableCell(withIdentifier: "IASettingsButtonTableViewCell", for: indexPath) as! IASettingsButtonTableViewCell;
                aCell.btnSettingsButton.setTitle("Save password", for: UIControlState.normal);
                aCell.btnSettingsButton.backgroundColor = UIColor .blue;
                return aCell;
            }
        }
        else
        {
            let aCell = tableView.dequeueReusableCell(withIdentifier: "IASettingsButtonTableViewCell", for: indexPath) as! IASettingsButtonTableViewCell;
            aCell.btnSettingsButton.setTitle("Logout", for: UIControlState.normal);
            aCell.btnSettingsButton.backgroundColor = UIColor .red;
            return aCell;
        }
    }
}
