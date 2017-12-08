//
//  IASettingsUserDataTableViewCell.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 08/12/2017.
//

import UIKit

class IASettingsUserDataTableViewCell: UITableViewCell {
    @IBOutlet weak var lblUserDataLabel: UILabel!
    @IBOutlet weak var txtUserDataValue: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
