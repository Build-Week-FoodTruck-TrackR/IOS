//
//  MainViewController.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/23/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var mytrucks: [TruckRepresentation] = []
     var favoriteTrucks: [TruckRepresentation] = []
     
	@IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addTruckBarButtonItem: UIBarButtonItem!
    
    let vendorController = VendorController()

	lazy var fetch: NSFetchedResultsController<Vendor> = {

		let request: NSFetchRequest<Vendor> = Vendor.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: "username", ascending: true)]

		let frc = NSFetchedResultsController(fetchRequest: request,
											 managedObjectContext: CoreDataStack.shared.mainContext,
                                             sectionNameKeyPath: "username",
                                             cacheName: nil)
        frc.delegate = self
		do {
			try frc.performFetch()
		} catch {
			fatalError("Error performing fetch for frc: \(error)")
		}
		return frc
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.delegate = self
		tableView.dataSource = self

		setColors()
		setupViews()
        
        setupTrucksForVendor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func setColors() {

		//let navBar = UINavigationBar.appearance()
		//self.navigationItem.title = "Testing title"
		self.navigationController?.navigationBar.isTranslucent = true
		//self.navigationController?.navigationBar.barTintColor = UIColor.titleBarColor
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textWhite]
		self.navigationController?.navigationBar.barTintColor = UIColor.titleBarColor
		//self.navigationController?.navigationBar.backgroundColor = UIColor.titleBarColor
		self.navigationController?.navigationBar.tintColor = UIColor.textWhite

		//navBar.tintColor = UIColor.textWhite
		//navBar.barTintColor = UIColor.titleBarColor

		//self.navigationController?.navigationBar.tintColor = UIColor.titleBarColor
		//self.navigationController?.navigationBar.barTintColor = UIColor.titleBarColor
		//navigationController?.navigationBar.barTintColor = UIColor.titleBarColor

	}

	// Make everything pretty
	private func setupViews() {
        if LoginViewController.isVendor {
            navigationItem.title = "My Trucks"
            addTruckBarButtonItem.isEnabled = true
            addTruckBarButtonItem.tintColor = .systemBlue
        } else {
            navigationItem.title = "Favorite Trucks"
            addTruckBarButtonItem.isEnabled = false
            addTruckBarButtonItem.tintColor = .clear
        }
        
		let navBarAppearance = UINavigationBarAppearance()

		view.backgroundColor = UIColor.titleBarColor
        //foodTruckSearchBar.barTintColor = .background

        tabBarController?.tabBar.barStyle = .default
		tabBarController?.tabBar.barTintColor = UIColor.titleBarColor
		tabBarController?.tabBar.tintColor = UIColor.textWhite

		navBarAppearance.configureWithDefaultBackground()
		navBarAppearance.backgroundColor = UIColor.titleBarColor

        navigationController?.navigationBar.barStyle = .default
		navigationController?.navigationBar.barTintColor = UIColor.titleBarColor
		navigationController?.navigationBar.backgroundColor = UIColor.titleBarColor


		navigationController?.navigationBar.tintColor = UIColor.textWhite
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textWhite]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textWhite]
    }


	// MARK: - Table view data source

	private func checkForBearerToken() {
		if vendorController.token == nil {
			performSegue(withIdentifier: "LoginModalSegue", sender: self)
		}
	}

	func numberOfSections(in tableView: UITableView) -> Int {

		//return fetch.sections?.count ?? 1
        return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if LoginViewController.isVendor == false {
            return favoriteTrucks.count
        } else {
            return mytrucks.count
        }
		//return fetch.sections?[section].numberOfObjects ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

          guard let cell = tableView.dequeueReusableCell(withIdentifier: "TruckCell", for: indexPath) as? VendorTableViewCell else { return UITableViewCell() }
            let truck = mytrucks[indexPath.row]
            cell.truck = truck
            return cell
        
		//cell.vendorController = vendorController
		//cell.vendor = fetch.object(at: indexPath)
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
            

		}
	}
    private func setupTrucksForVendor() {
        let truck1 = TruckRepresentation(location: LocationRepresentaion(longitute: 0, latitude: 0), imageOfTruck: "foodtruck1", customerAvgRating: 4.0, truckName: "Lucys subs", identifier: UUID())
            let truck2 = TruckRepresentation(location: LocationRepresentaion(longitute: 0, latitude: 0), imageOfTruck: "foodTruck2", customerAvgRating: 4.0, truckName: "big daddies pizza", identifier: UUID())
            let truck3 = TruckRepresentation(location: LocationRepresentaion(longitute: 0, latitude: 0), imageOfTruck: "foodtruck3", customerAvgRating: 4.0, truckName: "black sheep burgers", identifier: UUID())
            let truck4 = TruckRepresentation(location: LocationRepresentaion(longitute: 0, latitude: 0), imageOfTruck: "foodtruck4", customerAvgRating: 4.0, truckName: "kebobs", identifier: UUID())
            let trucks = [truck1,truck2,truck3,truck4]
            mytrucks.append(contentsOf: trucks)
    }
//    private func setupTrucksForConsumer() {
//            let truck1 = Truck(truckName: "Lucys subs", customerAvgRating: 4.2, location: Location(longitude: 1.0, latitude: 4.6), imageOfTruck: "foodtruck1")
//            let truck2 = Truck(truckName: "black sheep", customerAvgRating: 4.2, location: Location(longitude: 1.0, latitude: 4.6), imageOfTruck: "foodTruck2")
//            let truck3 = Truck(truckName: "Lucky 13", customerAvgRating: 4.2, location: Location(longitude: 1.0, latitude: 4.6), imageOfTruck: "foodtruck3")
//            let truck4 = Truck(truckName: "blueCoffee", customerAvgRating: 4.2, location: Location(longitude: 1.0, latitude: 4.6), imageOfTruck: "foodtruck4")
//            let trucks = [truck1,truck2,truck3,truck4]
//            favoriteTrucks.append(contentsOf: trucks)
//    }

}

extension MainViewController: NSFetchedResultsControllerDelegate {

	func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		tableView.beginUpdates()
	}

	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		tableView.endUpdates()
	}

	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {

		switch type {
		case .insert:
			guard let newIndexPath = newIndexPath else { return }
			tableView.insertRows(at: [newIndexPath], with: .automatic)
		case .delete:
			guard let indexPath = indexPath else { return }
			tableView.deleteRows(at: [indexPath], with: .automatic)
		case .move:
			guard let newIndexPath = newIndexPath,
				let indexPath = indexPath else { return }
			tableView.moveRow(at: indexPath, to: newIndexPath)
		case .update:
			guard let indexPath = indexPath else { return }
			tableView.reloadRows(at: [indexPath], with: .automatic)
		@unknown default:
			return
		}
	}

	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {

		let set = IndexSet(integer: sectionIndex)
		switch type {
		case .insert:
			tableView.insertSections(set, with: .automatic)
		case .delete:
			tableView.deleteSections(set, with: .automatic)
		default:
			return
		}
	}
}
