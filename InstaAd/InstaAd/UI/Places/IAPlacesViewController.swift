//
//  IAPlacesViewController.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 26/11/2017.
//

import UIKit
import FirebaseDatabase

class IAPlacesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var databaseReference : DatabaseReference!
    var placesList = [Place]()

    
    @IBOutlet var placesViewTable: UITableView!
    
    
        

    override func viewDidLoad() {
        
        super.viewDidLoad()
        databaseReference = Database.database().reference();
//        tu zoveš fetchPlaces

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = placesViewTable.dequeueReusableCell(withIdentifier: "IAPlacesTableViewCell", for: indexPath) as! IAPlacesTableViewCell
        return cell;
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
