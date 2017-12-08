//
//  IAHomeViewController.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 15/11/2017.
//

import UIKit
import FirebaseDatabase

class IAHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var databaseReference : DatabaseReference!
    var eventList = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad();
        databaseReference = Database.database().reference();
        fetchEvents();
        self.tableView.reloadData();

        tableView.register(UINib (nibName: "IAHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "IAHomeTableViewCell");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 356;
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IAHomeTableViewCell", for: indexPath) as! IAHomeTableViewCell

        if let url = NSURL(string: eventList[indexPath.row].eventImage!)
        {
            if let data = try? Data (contentsOf: url as URL)
            {
                cell.imgEventImage.image = UIImage(data: data)
            }
        }
        cell.lblEventName.text = eventList[indexPath.row].eventName;
        cell.lblEventPlace.text = eventList[indexPath.row].eventAddress;
        cell.lblEventDateTime.text = eventList[indexPath.row].eventStartDate;

        cell.layer.shadowOffset = CGSize (width: 1, height: 1)
        cell.layer.cornerRadius = 5;
        cell.layer.borderWidth = 3;
        let borderColor = UIColor .brown;
        cell.layer.borderColor = borderColor.cgColor;
        return cell;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pushViewController = IADetailsViewController();
        pushViewController.eventToDisplay = eventList[indexPath.row];
        self.navigationController?.pushViewController(pushViewController, animated: true);
    }

    //method for fetching values from database
    func fetchEvents() -> Void {
        databaseReference = databaseReference.child("dogadaji");
        databaseReference.observe(.value, with: { (snapshot) in

            if (snapshot.childrenCount > 0)
            {
                self.eventList.removeAll();
                for events in snapshot.children.allObjects as! [DataSnapshot]
                {
                    let eventObject = events.value as! [String: AnyObject];
                    let event = Event();
                    event.eventAddress = eventObject["adresa"] as? String;
                    event.eventStartDate = eventObject["datum_pocetka"] as? String;
                    event.eventEndDate = eventObject["datum_kraj"] as? String;
                    event.eventLatitude = eventObject["latitude"] as? String;
                    event.eventLongitude = eventObject["longitude"] as? String;
                    event.eventName = eventObject["naziv"] as? String;
                    event.eventDescription = eventObject["opis"] as? String;
                    event.eventImage = eventObject["slika"] as? String;

                    self.eventList.append(event);
                }

                self.tableView.reloadData();
            }
        });
    }
}
