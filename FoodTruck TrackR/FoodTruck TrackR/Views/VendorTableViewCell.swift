//
//  VendorTableViewCell.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/22/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit

class VendorTableViewCell: UITableViewCell {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var truckNameLabel: UILabel!
	@IBOutlet weak var cusineTypeLabel: UILabel!
	@IBOutlet weak var customerRatingLabel: UILabel!
	@IBOutlet weak var AvgCustomerRatingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
