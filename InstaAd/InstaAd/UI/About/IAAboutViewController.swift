//
//  IAAboutViewController.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 27/12/2017.
//

import UIKit

class IAAboutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib (nibName: "IAAbuoutTableViewCell", bundle: nil), forCellReuseIdentifier: "IAAbuoutTableViewCell");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0)
        {
            return 3;
        }

        return 2;
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50;
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section
        {
        case 0:
            return "Application details";
        case 1:
            return "Contact";
        default:
            return "";
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IAAbuoutTableViewCell", for: indexPath) as! IAAbuoutTableViewCell;

        if (indexPath.section == 0)
        {
            if (indexPath.row == 0)
            {
                cell.lblAboutTitle.text = "Version";
                cell.txtAboutDescription.text = "1.0.0";
            }
            else if (indexPath.row == 1)
            {
                cell.lblAboutTitle.text = "Released";
                cell.txtAboutDescription.text = "2017-12-27";
            }
            else
            {
                cell.lblAboutTitle.text = "Devloped by";
                cell.txtAboutDescription.text = "Team AIR1712";
            }
        }
        else
        {
            if (indexPath.row == 0)
            {
                cell.lblAboutTitle.text = "Email";
                cell.txtAboutDescription.text = "instad1617@gmail.com";
            }
            else
            {
                cell.lblAboutTitle.text = "Telephone";
                cell.txtAboutDescription.text = "+385 xx xxx xxxx";
            }
        }

        cell.txtAboutDescription.isEnabled = false;
        return cell;
    }
}
