//
//  IAHomeViewController.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 15/11/2017.
//

import UIKit

class IAHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad();
        //TODO first load all entries from database (in a function and save them in array)
        tableView.register(UINib (nibName: "IAHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "IAHomeTableViewCell");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 356;
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO check how many entries is in json and then return that value
        //TODO check how many entries is in database and then return that value (from array)
        return 5;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IAHomeTableViewCell", for: indexPath) as! IAHomeTableViewCell
        cell.imgEventImage.image = UIImage (named: "instaAd_no_image_available");
        cell.lblEventName.text = "Prvi studentski party ove godine u Barfly-u";
        cell.lblEventPlace.text = "Barfly";
        cell.lblEventDateTime.text = "1.12.2018";

        return cell;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pushViewController = IADetailsViewController();
        self.navigationController?.pushViewController(pushViewController, animated: true);
    }
}
