//
//  IAHomeViewController.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 15/11/2017.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class IAHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var databaseReference : DatabaseReference!
    var eventList = [Event]()
    var filteredEventList = [Event]()
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad();
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        searchBar.delegate = self;
        searchBar.returnKeyType = UIReturnKeyType.done;
        databaseReference = Database.database().reference();

        fetchEvents();
        self.tableView.reloadData();

        tableView.register(UINib (nibName: "IAHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "IAHomeTableViewCell");

        //redirect user to login page if it's not logged in
        let user = Auth.auth().currentUser;
        if (user == nil)
        {
            let loginButton = UIBarButtonItem (image: UIImage (named: "instaAd_home_login"), style: .plain, target: self, action: #selector(IAHomeViewController.goToLoginPage));
            self.navigationItem.rightBarButtonItem = loginButton;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func goToLoginPage() -> Void {
        let pushViewController = IALoginViewController();
        self.navigationController?.pushViewController(pushViewController, animated: true);
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 356;
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if (isSearching)
        {
            return filteredEventList.count;
        }

        return eventList.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IAHomeTableViewCell", for: indexPath) as! IAHomeTableViewCell

        if (isSearching)
        {
            if let url = NSURL(string: filteredEventList[indexPath.section].eventImage!)
            {
                if let data = try? Data (contentsOf: url as URL)
                {
                    cell.imgEventImage.image = UIImage(data: data)
                }
            }
            cell.lblEventName.text = filteredEventList[indexPath.section].eventName;
            cell.lblEventPlace.text = filteredEventList[indexPath.section].eventAddress;
            cell.lblEventDateTime.text = filteredEventList[indexPath.section].eventStartDate;
        }
        else
        {
            if let url = NSURL(string: eventList[indexPath.section].eventImage!)
            {
                if let data = try? Data (contentsOf: url as URL)
                {
                    cell.imgEventImage.image = UIImage(data: data)
                }
            }
            cell.lblEventName.text = eventList[indexPath.section].eventName;
            cell.lblEventPlace.text = eventList[indexPath.section].eventAddress;
            cell.lblEventDateTime.text = eventList[indexPath.section].eventStartDate;
        }

        cell.btnShare.tag = indexPath.section;
        cell.btnShare.addTarget(self, action: #selector(shareButtonClicked(sender:)), for: .touchUpInside);

        cell.layer.shadowOffset = CGSize (width: 1, height: 1)
        cell.layer.cornerRadius = 5;
        cell.layer.borderWidth = 3;
        let borderColor = UIColor .black;
        cell.layer.borderColor = borderColor.cgColor;

        return cell;
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section != 0)
        {
            return 10;
        }

        return 0;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = Auth.auth().currentUser;
        if (user != nil)
        {
            let pushViewController = IADetailsViewController();
            pushViewController.eventToDisplay = eventList[indexPath.section];
            self.navigationController?.pushViewController(pushViewController, animated: true);
        }
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
                    event.eventUrl = eventObject["url"] as? String;
                    event.eventObject = eventObject["objekt"] as? String;

                    let dateFormatter = DateFormatter();
                    dateFormatter.dateFormat = "yyyy-MM-dd";
                    let eventDate = dateFormatter.date(from: eventObject["datum_pocetka"] as! String);
                    let currentDate = Date();

                    if (eventDate! >= currentDate)
                    {
                        var position = -1;
                        var isInserted = false;
                        if (self.eventList.count > 0)
                        {
                            for selectedEvent in self.eventList
                            {
                                position = position + 1;
                                let selectedEventDate = dateFormatter.date(from: selectedEvent.eventStartDate!);
                                if ((selectedEventDate?.compare(eventDate!)) == .orderedDescending)
                                {
                                    self.eventList.insert(event, at: position);
                                    isInserted = true;
                                    break;
                                }
                            }

                            if (!isInserted)
                            {
                                self.eventList.append(event);
                            }
                        }
                        else
                        {
                            self.eventList.insert(event, at: 0);
                        }
                    }
                }

                self.tableView.reloadData();
            }
        });
    }

    @objc func shareButtonClicked(sender:UIButton){
        let buttonSection = sender.tag;
        let activityViewController = UIActivityViewController (activityItems: [self.eventList[buttonSection].eventUrl ?? "URL is not available"], applicationActivities: nil);
        activityViewController.popoverPresentationController?.sourceView = self.view;

        self.present(activityViewController, animated: true, completion: nil);
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == nil || searchBar.text == "")
        {
            isSearching = false;
            view.endEditing(true);
            tableView.reloadData();
        }
        else
        {
            isSearching = true;
            self.filteredEventList.removeAll();

            for selectEvent in self.eventList
            {
                if ((selectEvent.eventName?.lowercased().range(of: searchBar.text!.lowercased())) != nil)
                {
                    self.filteredEventList.append(selectEvent);
                }
                NSLog(selectEvent.eventName!.lowercased());
            }

            tableView.reloadData();
        }
    }
}
