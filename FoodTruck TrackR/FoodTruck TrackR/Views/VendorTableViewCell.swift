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
    @IBOutlet private weak var AvgRatingLabel: UILabel!
    
	var vendorController = VendorController.shared

	var truck: TruckRepresentation? {
		didSet {
            updateViews()
		}
	}

    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        guard let truck = truck else { return }
        truckImageView.image = UIImage(named: truck.imageOfTruck)
        truckNameLabel.text = truck.truckName
        cusineTypeLabel.text = truck.cuisineType
        AvgRatingLabel.text = "\(truck.customerAvgRating)/5 Stars"
    }
}
