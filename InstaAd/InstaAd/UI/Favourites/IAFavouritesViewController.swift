//
//  IAFavouritesViewController.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 15/11/2017.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class IAFavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var databaseReference : DatabaseReference!
    var databaseReferenceEvents : DatabaseReference!
    var favouritesEventList = [Event]();
    var userFavouritePlacesList = [String]();

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        databaseReference = Database.database().reference();

        fetchUserFavouritePlaces();
        self.tableView.reloadData();

        tableView.register(UINib (nibName: "IAHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "IAHomeTableViewCell");
        tableView.register(UINib (nibName: "IAFavouritesEmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "IAFavouritesEmptyTableViewCell");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (favouritesEventList.count > 0)
        {
            return 356;
        }

        return 50;
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        NSLog(String(favouritesEventList.count));
        if (favouritesEventList.count > 0)
        {
            return favouritesEventList.count;
        }

        return 1;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section != 0)
        {
            return 10;
        }

        return 0;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (favouritesEventList.count > 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IAHomeTableViewCell", for: indexPath) as! IAHomeTableViewCell

            if let url = NSURL(string: favouritesEventList[indexPath.section].eventImage!)
            {
                if let data = try? Data (contentsOf: url as URL)
                {
                    cell.imgEventImage.image = UIImage(data: data)
                }
            }

            cell.lblEventName.text = favouritesEventList[indexPath.section].eventName;
            cell.lblEventPlace.text = favouritesEventList[indexPath.section].eventAddress;
            cell.lblEventDateTime.text = favouritesEventList[indexPath.section].eventStartDate;

            cell.btnShare.tag = indexPath.section;
            cell.btnShare.addTarget(self, action: #selector(shareButtonClicked(sender:)), for: .touchUpInside);

            cell.layer.shadowOffset = CGSize (width: 1, height: 1)
            cell.layer.cornerRadius = 5;
            cell.layer.borderWidth = 3;
            let borderColor = UIColor .black;
            cell.layer.borderColor = borderColor.cgColor;

            return cell;
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IAFavouritesEmptyTableViewCell", for: indexPath) as! IAFavouritesEmptyTableViewCell
            cell.txtFavouritesEmpytDescription.text = "You don't have any favourite place or you're favourite places currently don't have none event!";

            return cell;
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (favouritesEventList.count > 0)
        {
            let pushViewController = IADetailsViewController();
            pushViewController.eventToDisplay = favouritesEventList[indexPath.section];
            self.navigationController?.pushViewController(pushViewController, animated: true);
        }
    }

    //methods for fetching values from database
    func fetchUserFavouritePlaces() -> Void {
        let user = Auth.auth().currentUser;

        databaseReference = databaseReference.child("users").child((user?.uid)!).child("favs");
        databaseReference.observe(.value, with: { (snapshot) in

            if (snapshot.childrenCount > 0)
            {
                self.userFavouritePlacesList.removeAll();
                for place in snapshot.children.allObjects as! [DataSnapshot]
                {
                    var placeName = "";
                    placeName = place.key as String;
                    self.userFavouritePlacesList.append(placeName);
                    NSLog(placeName);
                }

                self.fetchEvents();
                self.tableView.reloadData();
            }
        });
    }

    //method for fetching values from database
    func fetchEvents() -> Void {
        databaseReference = Database.database().reference().child("dogadaji");
        databaseReference.observe(.value, with: { (snapshot) in

            if (snapshot.childrenCount > 0)
            {
                self.favouritesEventList.removeAll();
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
                    event.eventUrl = eventObject["url"] as? String;
                    event.eventObject = eventObject["objekt"] as? String;

                    let dateFormatter = DateFormatter();
                    dateFormatter.dateFormat = "yyyy-MM-dd";
                    let eventDate = dateFormatter.date(from: eventObject["datum_pocetka"] as! String);
                    let currentDate = Date();

                    if (eventDate! >= currentDate)
                    {
                        var validEvent = false;
                        for selectedEvent in self.userFavouritePlacesList
                        {
                            if (selectedEvent == event.eventObject)
                            {
                                validEvent = true;
                            }
                        }

                        if (validEvent == true)
                        {
                            var position = -1;
                            var isInserted = false;
                            if (self.favouritesEventList.count > 0)
                            {
                                for selectedEvent in self.favouritesEventList
                                {
                                    position = position + 1;
                                    let selectedEventDate = dateFormatter.date(from: selectedEvent.eventStartDate!);
                                    if ((selectedEventDate?.compare(eventDate!)) == .orderedDescending)
                                    {
                                        self.favouritesEventList.insert(event, at: position);
                                        isInserted = true;
                                        break;
                                    }
                                }

                                if (!isInserted)
                                {
                                    self.favouritesEventList.append(event);
                                }
                            }
                            else
                            {
                                self.favouritesEventList.insert(event, at: 0);
                            }
                        }
                    }
                }
                self.tableView.reloadData()
            }
        });
    }

    @objc func shareButtonClicked(sender:UIButton){
        let buttonSection = sender.tag;
        let activityViewController = UIActivityViewController (activityItems: [self.favouritesEventList[buttonSection].eventUrl ?? "URL is not available"], applicationActivities: nil);
        activityViewController.popoverPresentationController?.sourceView = self.view;

        self.present(activityViewController, animated: true, completion: nil);
    }
}
