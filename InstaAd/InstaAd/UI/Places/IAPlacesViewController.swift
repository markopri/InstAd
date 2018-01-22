//
//  IAPlacesViewController.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 26/11/2017.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class IAPlacesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet var placesViewTable: UITableView!
    var databaseReference : DatabaseReference!
    var placesList = [Place]()
    var placesFavsList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        databaseReference = Database.database().reference();
        fetchFavs()
        
        self.placesViewTable.reloadData()
        
        placesViewTable.register(UINib (nibName: "IAPlacesTableViewCell", bundle: nil), forCellReuseIdentifier: "IAPlacesTableViewCell");

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = placesViewTable.dequeueReusableCell(withIdentifier: "IAPlacesTableViewCell", for: indexPath) as! IAPlacesTableViewCell
        
        cell.tableViewLabel.text = placesList[indexPath.row].placeName
        
        cell.tableViewBtn.tag = indexPath.row
        cell.tableViewBtn.addTarget(self, action: #selector(likeButtonClicked(sender: )), for: .touchUpInside)
        
        if(placesList[indexPath.row].placeFavorite)!{
            cell.tableViewBtn.setBackgroundImage(UIImage (named: "instaAd_liked_place"), for: .normal)
        }else{
            cell.tableViewBtn.setBackgroundImage(UIImage (named: "instaAd_non_liked_place"), for: .normal)
        }
        
        
        
        return cell;
    }
    
    func fetchFavs() -> Void {
        let userID = Auth.auth().currentUser?.uid
        let databaseReferenceFav = databaseReference.child("users").child(userID!).child("favs")
        
        databaseReferenceFav.observe(.value, with: { (snapshot) in
            
            if (snapshot.childrenCount > 0)
            {
                for places in snapshot.children.allObjects as! [DataSnapshot]
                {
                    var placeName = ""
                    placeName = places.key as String
                    self.placesFavsList.append(placeName)
                    
                }
                self.fetchPlaces()
            }
        });
        
    }
    
    func fetchPlaces() -> Void {
        databaseReference = databaseReference.child("lokacije");
        
        
        databaseReference.observe(.value, with: { (snapshot) in
            
            if (snapshot.childrenCount > 0)
            {
                self.placesList.removeAll();
                for places in snapshot.children.allObjects as! [DataSnapshot]
                {
                    let placeObject = places.value as! [String: AnyObject];
                    let place = Place();
                    
                    place.placeId = placeObject["id"] as? String
                    place.placeName = placeObject["naziv"]  as? String
                    place.placeAdress = placeObject["adresa"] as? String
                    place.placeLat = placeObject["latitude"] as? String
                    place.placeLong = placeObject["longitude"] as? String
                    
                    var isFavorite = false
                    
                    for selectedFav in self.placesFavsList{
                        
                        if(selectedFav == place.placeName){
                            
                            isFavorite = true
                        }
                    }
                    
                    place.placeFavorite = isFavorite
                    
                    self.placesList.append(place)
                    self.placesViewTable.reloadData()
                    
                }
            }
        });
       self.placesViewTable.reloadData()
    }

    @objc func likeButtonClicked (sender: UIButton){
        let buttonRow = sender.tag;
        let user = Auth.auth().currentUser;
        if (self.placesList[buttonRow].placeFavorite)!
        {
            self.placesList[buttonRow].placeFavorite = false;
            var databaseRefernece : DatabaseReference!;
            databaseRefernece = Database.database().reference();

            let userDatabaseReference = databaseRefernece.child("users").child((user?.uid)!).child("favs").child(self.placesList[buttonRow].placeName!);
            userDatabaseReference.removeValue();
            self.placesViewTable.reloadData();
        }
        else
        {
            self.placesList[buttonRow].placeFavorite = true;
            var databaseRefernece : DatabaseReference!;
            databaseRefernece = Database.database().reference();

            let userDatabaseReference = databaseRefernece.child("users").child((user?.uid)!).child("favs").child(self.placesList[buttonRow].placeName!);
            userDatabaseReference.setValue("dodan");
            self.placesViewTable.reloadData();
        }
    }
}
