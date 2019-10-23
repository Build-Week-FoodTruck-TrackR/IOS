//
//  TruckController.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/22/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation
import CoreData

class TruckController {

	// MARK: - Properties
    var trucks: [Truck] = []
    
    static let shared = TruckController()

	func getTruck(with searchTerm: String?) -> [Truck] {
        guard let searchTerm = searchTerm, !searchTerm.isEmpty else { return [] }
        
        let filteredNames = trucks.filter({(item: Truck) -> Bool in
            let stringMatch = item.truckName?.lowercased().range(of: searchTerm.lowercased())
                return stringMatch != nil ? true : false
        })
        return filteredNames
    }

	func createTruck(with truckName: String, location: Location, imageOfTruck: String, identifier: UUID = UUID()) {
        let truck = Truck(truckName: truckName, customerAvgRating: 0, location: Location(longitude: 0, latitude: 0), imageOfTruck: "")
        put(truck: truck)
        saveToPersistentStore()
    }
    
    func updateLocation(truck: Truck, location: Location) {
        truck.location = location
        put(truck: truck)
        saveToPersistentStore()
    }
    
    func delete(truck: Truck) {
        CoreDataStack.shared.mainContext.delete(truck)
        deleteTruckFromServer(truck: truck)
        saveToPersistentStore()
    }
    
    private func put(truck: Truck, completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        let identifier = truck.identifier?.uuidString ?? UUID().uuidString
        let requestURL = baseURL.appendingPathComponent(identifier).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        guard let location = truck.location, let imageOfTruck = truck.imageOfTruck, let name = truck.truckName, let id = truck.identifier else { return }
        
        let truckRep = TruckRepresentation(location: LocationRepresentaion(longitute: location.longitude, latitude: location.latitude), imageOfTruck: imageOfTruck, customerAvgRating: truck.customerAvgRating, truckName: name, identifier: id)
        
        do {
            request.httpBody = try JSONEncoder().encode(truckRep)
        } catch {
            NSLog("Error encoding rruck: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error PUTting truck to server: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    func deleteTruckFromServer(truck: Truck, completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        guard let identifier = truck.identifier else {
            NSLog("Truck identifier is nil")
            completion(NSError())
            return
        }
        
        let requestURL = baseURL.appendingPathComponent(identifier.uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error deleting truck from server: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    func fetchTrucksFromServer(completion: @escaping (([TruckRepresentation]?, Error?) -> Void) = { _,_ in }) {
        
        let requestURL = baseURL.appendingPathExtension("json")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching entries from server: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(nil, NSError())
                return
            }

            do {
                let truckReps = try JSONDecoder().decode([String: TruckRepresentation].self, from: data).map({$0.value})
                completion(truckReps, nil)
            } catch {
                NSLog("Error decoding JSON data: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    func refreshTrucksFromServer() {
        fetchTrucksFromServer { (representations, error) in
            if error != nil { return }
            guard let representations = representations else { return }
            let moc = CoreDataStack.shared.container.newBackgroundContext()
            self.updateTrucks(with: representations, in: moc)
        }
    }
    
    func updateTrucks(with representations: [TruckRepresentation], in context: NSManagedObjectContext) {
        let identifiersToFetch = representations.compactMap({ $0.identifier })
        let representationsByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, representations))
        var trucksToCreate = representationsByID
        
        context.performAndWait {
            do {
                let fetchRequest: NSFetchRequest<Truck> = Truck.fetchRequest()

                fetchRequest.predicate = NSPredicate(format: "identifier IN %@", identifiersToFetch)

                let existingTrucks = try context.fetch(fetchRequest)
                var tempArr: [Truck] = []
                for truck in existingTrucks {
                    guard let identifier = truck.identifier,
                        let representation = representationsByID[identifier] else { continue }
                    
                    truck.truckName = representation.truckName
                    truck.location = Location(longitude: representation.location.longitute, latitude: representation.location.latitude)
                    truck.customerAvgRating = representation.customerAvgRating
                    truck.imageOfTruck = representation.imageOfTruck
                    
                    trucksToCreate.removeValue(forKey: identifier)
                    
                    tempArr.append(truck)
                }
                
                for representation in trucksToCreate.values {
                    let truck = Truck(truck: representation, context: context)
                    tempArr.append(truck)
                }
                trucks = tempArr
                saveToPersistentStore()
                
            } catch {
                NSLog("Error fetching objects from persistent store: \(error)")
            }
        }
    }
    
    func fetchSingleTruckFromPersistentStore(identifier: UUID, context: NSManagedObjectContext) -> Truck? {
        var tempTruck: Truck?
        
        let fetchRequest: NSFetchRequest<Truck> = Truck.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", identifier.uuidString)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "identifier", ascending: true)]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.mainContext, sectionNameKeyPath: "identifier", cacheName: nil)
        
        do {
            try frc.performFetch()
            
            tempTruck = frc.object(at: IndexPath(row: 0, section: 0))
        } catch {
            NSLog("Error performing fetch for frc: \(error)")
        }
        
        return tempTruck
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
}
