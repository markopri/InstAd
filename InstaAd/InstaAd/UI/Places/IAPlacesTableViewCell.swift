//
//  IAPlacesTableViewCell.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 08/12/2017.
//

import UIKit

class IAPlacesTableViewCell: UITableViewCell {

    @IBOutlet var tableViewLabel: UILabel!
    @IBOutlet var tableViewBtn: UIButton!
    
    @IBAction func pressedPlacesButton(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
