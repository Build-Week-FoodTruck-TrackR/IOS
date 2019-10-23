//
//  FoodTruckTableViewCell.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/20/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit

class FoodTruckTableViewCell: UITableViewCell {
    
    var truck: Truck? {
        didSet {
            updateViews()
        }
    }
    
    var distanceAway: Double?
    
    @IBOutlet weak var foodTruckImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceAwayLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateViews()
    }
    
    func updateViews() {
        guard let truck = truck else { return }
        
        nameLabel.text = truck.truckName
        if let distanceAway = distanceAway {
            distanceAwayLabel.text = "\(distanceAway) away"
        } else {
            distanceAwayLabel.text = "N/A away"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func toggleFavorite(_ sender: UIButton) {
        
    }
    
}
