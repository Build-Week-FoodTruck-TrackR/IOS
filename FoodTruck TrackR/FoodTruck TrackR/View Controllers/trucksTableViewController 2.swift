//
//  trucksTableViewController.swift
//  FoodTruck TrackR
//
//  Created by brian vilchez on 10/25/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit

class trucksTableViewController: UITableViewController {

    var mytrucks: [Truck] = []
    var favoriteTrucks: [Truck] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
  setupTrucksForVendor()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mytrucks.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? VendorTableViewCell else { return UITableViewCell()}
        let truck = mytrucks[indexPath.row]
        cell.truck = truck.truckRepresentation
        return cell
    }
    
         private func setupTrucksForVendor() {
            let truck1 = Truck(truckName: "Lucys subs", customerAvgRating: 4.2, location: Location(longitude: 1.0, latitude: 4.6), imageOfTruck: "foodtruck1")
            let truck2 = Truck(truckName: "black sheep", customerAvgRating: 4.2, location: Location(longitude: 1.0, latitude: 4.6), imageOfTruck: "foodTruck2")
            let truck3 = Truck(truckName: "Lucky 13", customerAvgRating: 4.2, location: Location(longitude: 1.0, latitude: 4.6), imageOfTruck: "foodtruck3")
            let truck4 = Truck(truckName: "blueCoffee", customerAvgRating: 4.2, location: Location(longitude: 1.0, latitude: 4.6), imageOfTruck: "foodtruck4")
            let trucks = [truck1,truck2,truck3,truck4]
            mytrucks.append(contentsOf: trucks)
    }
}
