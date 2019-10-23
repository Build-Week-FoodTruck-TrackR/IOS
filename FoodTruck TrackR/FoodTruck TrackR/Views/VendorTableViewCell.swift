//
//  VendorTableViewCell.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/22/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit

class VendorTableViewCell: UITableViewCell {

	@IBOutlet weak var truckImageView: UIImageView!
	@IBOutlet weak var truckNameLabel: UILabel!
	@IBOutlet weak var cusineTypeLabel: UILabel!
	@IBOutlet weak var customerRatingLabel: UILabel!
	@IBOutlet weak var AvgCustomerRatingLabel: UILabel!

	var vendorController = VendorController.shared

	var vendor: Vendor?{
		didSet {

		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
