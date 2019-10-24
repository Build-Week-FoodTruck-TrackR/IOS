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

	@IBOutlet private weak var tableView: UITableView!

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

		let navBarAppearance = UINavigationBarAppearance()

		view.backgroundColor = UIColor.titleBarColor
        //foodTruckSearchBar.barTintColor = .background

        tabBarController?.tabBar.barStyle = .default
		tabBarController?.tabBar.barTintColor = UIColor.titleBarColor
		tabBarController?.tabBar.tintColor = UIColor.textWhite

		navBarAppearance.configureWithDefaultBackground()
		navBarAppearance.backgroundColor = UIColor.titleBarColor

		navigationItem.title = "Testing title"
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

		return fetch.sections?.count ?? 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return fetch.sections?[section].numberOfObjects ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "TruckCell", for: indexPath) as? FoodTruckTableViewCell else { return UITableViewCell() }

		//cell.vendorController = vendorController
		//cell.vendor = fetch.object(at: indexPath)

		return cell
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {


		}
	}


    /*
    // MARK: - Navigation


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
