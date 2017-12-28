//
//  IAAbuoutTableViewCell.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 27/12/2017.
//

import UIKit

class IAAbuoutTableViewCell: UITableViewCell {
    @IBOutlet weak var lblAboutTitle: UILabel!
    @IBOutlet weak var txtAboutDescription: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
