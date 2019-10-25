//
//  VendorTableViewCell.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/22/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit

class VendorTableViewCell: UITableViewCell {

	@IBOutlet private weak var truckImageView: UIImageView!
	@IBOutlet private weak var truckNameLabel: UILabel!
	@IBOutlet private weak var cusineTypeLabel: UILabel!
	@IBOutlet private weak var customerRatingLabel: UILabel!
	@IBOutlet private weak var AvgCustomerRatingLabel: UILabel!

	var vendorController = VendorController.shared

	var vendor: Vendor? {
		didSet {

		}
	}

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

	private func updateViews() {
		guard let vendor = vendor else { return }

		truckNameLabel.text = vendor.

	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }



}
