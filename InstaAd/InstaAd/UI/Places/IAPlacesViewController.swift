//
//  IAPlacesViewController.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 26/11/2017.
//

import UIKit
import FirebaseDatabase

class IAPlacesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet var placesViewTable: UITableView!
    var databaseReference : DatabaseReference!
    var placesList = [Place]()

    override func viewDidLoad() {
        super.viewDidLoad()
        databaseReference = Database.database().reference();
        fetchPlaces()
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
        
        if(indexPath.row%3==0){
            cell.tableViewBtn.setBackgroundImage(UIImage (named: "instaAd_liked_place"), for: .normal)
        }else{
            cell.tableViewBtn.setBackgroundImage(UIImage (named: "instaAd_non_liked_place"), for: .normal)
        }
        
        
        
        return cell;
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
                    
                    self.placesList.append(place)
                    self.placesViewTable.reloadData()
                    
                }
            }
        });
    }
    
    func isFavorite() -> Bool {
        return true
    }
    
    
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
