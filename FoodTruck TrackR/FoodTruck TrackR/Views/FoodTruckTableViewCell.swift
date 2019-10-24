//
//  FoodTruckTableViewCell.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/20/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit

protocol ShowTruckOnMap {
    func truckWasSelected(_ truck: Truck)
}

class FoodTruckTableViewCell: UITableViewCell {
    
    var truck: Truck? {
        didSet {
            updateViews()
        }
    }
    
    var delegate: ShowTruckOnMap?
    
    var distanceAway: Double?
    
    @IBOutlet private weak var foodTruckImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var distanceAwayLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
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
        if let truck = truck {
            delegate?.truckWasSelected(truck)
        }
    }
    
    @IBAction func toggleFavorite(_ sender: UIButton) {
        
    }
    
}
