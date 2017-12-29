//
//  IADetailsEventMapTableViewCell.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 26/11/2017.
//

import UIKit
import MapKit

class IADetailsEventMapTableViewCell: UITableViewCell {
    @IBOutlet weak var mkEventMap: MKMapView!
    @IBOutlet weak var eventToDisplayDirection : Event!

    @IBAction func btnShowMeDirectionClicked(_ sender: Any) {
        var latitude = 0.0;
        var longitude = 0.0;

        if let eventLatitude = eventToDisplayDirection.eventLatitude
        {
            latitude = Double(eventLatitude)!;
        }
        if let eventLongitude = eventToDisplayDirection.eventLongitude
        {
            longitude = Double(eventLongitude)!;
        }

        //Defining destination
        let destinationLatitude:CLLocationDegrees = latitude;
        let destinationLongitude:CLLocationDegrees = longitude;

        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(destinationLatitude, destinationLongitude);
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance);

        let options = [MKLaunchOptionsMapCenterKey: NSValue (mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue (mkCoordinateSpan: regionSpan.span)];

        if #available(iOS 10.0, *) {
            let placemark = MKPlacemark (coordinate: coordinates);
            let mapItem = MKMapItem (placemark: placemark);
            mapItem.name = eventToDisplayDirection.eventAddress;
            mapItem.openInMaps(launchOptions: options);
        } else {
            // Fallback on earlier versions
        };
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
