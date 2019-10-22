//
//  AccountsTableViewController.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/22/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {

	let vendorController = VendorController()

		lazy var fetch: NSFetchedResultsController<Vendor> = {

			let request: NSFetchRequest<Vendor> = Vendor.fetchRequest()
			request.sortDescriptors = [NSSortDescriptor(key: "username", ascending: true)]

			let frc = NSFetchedResultsController(fetchRequest: request,
												 managedObjectContext: CoreDataStack.shared.mainContext, sectionNameKeyPath: "username", cacheName: nil)

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

			self.clearsSelectionOnViewWillAppear = false
			self.navigationItem.rightBarButtonItem = self.editButtonItem
		}

		override func didReceiveMemoryWarning() {
			super.didReceiveMemoryWarning()
		}


	// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

		return fetch.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return fetch.sections?[section].numberOfObjects ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "TruckCell", for: indexPath) as? FoodTruckTableViewCell else { return UITableViewCell() }

		//cell.vendorController = vendorController
		//cell.vendor = fetch.object(at: indexPath)

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {


        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainTableViewController: NSFetchedResultsControllerDelegate {

	func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		tableView.beginUpdates()
	}

	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		tableView.endUpdates()
	}

	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

		switch type {
		case .insert:
			guard let newIndexPath = newIndexPath else {return}
			tableView.insertRows(at: [newIndexPath], with: .automatic)
		case .delete:
			guard let indexPath = indexPath else {return}
			tableView.deleteRows(at: [indexPath], with: .automatic)
		case .move:
			guard let newIndexPath = newIndexPath,
				let indexPath = indexPath else {return}
			tableView.moveRow(at: indexPath, to: newIndexPath)
		case .update:
			guard let indexPath = indexPath else {return}
			tableView.reloadRows(at: [indexPath], with: .automatic)
		@unknown default:
			return
		}
	}

	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {

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

