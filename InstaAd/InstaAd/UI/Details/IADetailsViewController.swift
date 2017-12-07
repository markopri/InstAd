//
//  IADetailsViewController.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 15/11/2017.
//

import UIKit
import MapKit

class IADetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventToDisplay : Event!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib (nibName: "IADetailsEventNameTableViewCell", bundle: nil), forCellReuseIdentifier: "IADetailsEventNameTableViewCell");
        tableView.register(UINib (nibName: "IADetailsEventImageTableViewCell", bundle: nil), forCellReuseIdentifier: "IADetailsEventImageTableViewCell");
        tableView.register(UINib (nibName: "IADetailsEventDTPTableViewCell", bundle: nil), forCellReuseIdentifier: "IADetailsEventDTPTableViewCell");
        tableView.register(UINib (nibName: "IADetailsEventDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "IADetailsEventDescriptionTableViewCell");
        tableView.register(UINib (nibName: "IADetailsEventMapTableViewCell", bundle: nil), forCellReuseIdentifier: "IADetailsEventMapTableViewCell");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6;
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row
        {
        case 0:
            return 44;
        case 1:
            return 217;
        case 2:
            return 44;
        case 3:
            return 44;
        case 4:
            return 100;
        case 5:
            return 300;
        default:
            return 44;
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row
        {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IADetailsEventNameTableViewCell", for: indexPath) as! IADetailsEventNameTableViewCell;
            cell.lblEventName.text = eventToDisplay.eventName;
            return cell;
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IADetailsEventImageTableViewCell", for: indexPath) as! IADetailsEventImageTableViewCell;
            if let url = NSURL(string: eventToDisplay.eventImage!)
            {
                if let data = try? Data (contentsOf: url as URL)
                {
                    cell.imgEventImage.image = UIImage(data: data)
                }
            }
            return cell;
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IADetailsEventDTPTableViewCell", for: indexPath) as! IADetailsEventDTPTableViewCell;
            cell.imgEventDTPIcon.image = UIImage (named: "instaAd_calendar");
            cell.lblEventDTPValue.text = eventToDisplay.eventStartDate;
            return cell;
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IADetailsEventDTPTableViewCell", for: indexPath) as! IADetailsEventDTPTableViewCell;
            cell.imgEventDTPIcon.image = UIImage (named: "instaAd_location");
            cell.lblEventDTPValue.text = eventToDisplay.eventAddress;
            return cell;
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IADetailsEventDescriptionTableViewCell", for: indexPath) as! IADetailsEventDescriptionTableViewCell;
            cell.txtEventDescription.text = eventToDisplay.eventDescription;
            return cell;
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IADetailsEventMapTableViewCell", for: indexPath) as! IADetailsEventMapTableViewCell;
            return cell;
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "IADetailsEventNameTableViewCell", for: indexPath) as! IADetailsEventNameTableViewCell;
            return cell;
        }
    }
}
