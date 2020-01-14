//
//  ConsumerController.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/22/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth

enum HTTPMethod: String {
	case get = "GET"
	case put = "PUT"
	case post = "POST"
	case delete = "DELETE"
}

enum NetworkError: Error {
	case encodingError
	case badResponse
	case otherError(Error)
	case noData
	case badDecode
	case noAuth
	case invalidInput
}

class ConsumerController {
    let ref = Database.database().reference()
    var user: ConsumerRepresentation?
    var token: String?

    static let shared = ConsumerController()

    func register(username: String, password: String, email: String, firstName: String, lastName: String, completion: @escaping(NetworkError?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.otherError(error))
                return
            }
            
            guard let result = result else {
                completion(.noData)
                return
            }
            
            let db = Firestore.firestore()
            db.collection("consumers").addDocument(data: ["username":username, "firstName":firstName, "lastName":lastName, "uid":result.user.uid]) { error in
                if let error = error {
                    completion(.otherError(error))
                    return
                }
                guard let email = result.user.email else { return }
                self.user = ConsumerRepresentation(username: username, email: email, currentLocation: LocationRepresentaion(longitute: 0, latitude: 0), favoriteTrucks: [TruckRepresentation](), identifier: result.user.uid)
//                self.token = result.
            }
        }
    }
    
    func logOut() {
        user = nil
        token = nil
    }

    func logIn(username: String, password: String, completion: @escaping(NetworkError?) -> Void) {

//        let requestURL = baseURL.appendingPathComponent("Consumer")
//                                .appendingPathComponent(user.username)
//                                .appendingPathExtension("json")
//
//
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.get.rawValue
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        // request.httpBody = componentString?.data(using: .utf8)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let response = response as? HTTPURLResponse,
//                response.statusCode != 201 && response.statusCode != 200 {
//                NSLog("Response status code is not 200 or 201. Status code: \(response.statusCode)")
//                completion(.badResponse)
//                return
//            }
//
//            if let error = error {
//                NSLog("Error verifying user: \(error)")
//                completion(.otherError(error))
//                return
//            }
//
//            guard let data = data else {
//                NSLog("No data returned from data task")
//                completion(.noData)
//                return
//            }
//
//            let jsonDecoder = JSONDecoder()
//
//            do {
//                let result = try jsonDecoder.decode(ConsumerRepresentation.self, from: data)
//                self.user = result
//                self.token = result.password
//                completion(nil)
//                // TODO: Create new Background thread
////                let context = CoreDataStack.shared.mainContext
////
////                context.performAndWait {
////                    _ = Consumer(user: result) // TODO: create CoreData object from representation
////                }
////
////                self.saveToPersistentStore()
//            } catch {
//                NSLog("Error decoding data/token: \(error)")
//                completion(.badDecode)
//                return
//            }
//        }.resume()
    }
    
    func updateLocation(for consumer: Consumer, longitude: Double, latitude: Double) {
        let location = Location(longitude: longitude, latitude: latitude)
        consumer.currentLocation = location
    }
    
    func addFavoriteTruck(truck: TruckRepresentation) {
        
    }


    func saveToPersistentStore() {
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
}
