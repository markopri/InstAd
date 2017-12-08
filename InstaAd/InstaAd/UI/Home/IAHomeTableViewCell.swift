//
//  IAHomeTableViewCell.swift
//  InstaAd
//
//  Created by Marko Koprivnjak on 20/11/2017.
//

import UIKit

class IAHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgEventImage: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventPlace: UILabel!
    @IBOutlet weak var lblEventDateTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
