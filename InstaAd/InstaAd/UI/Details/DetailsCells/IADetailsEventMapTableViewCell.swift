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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
