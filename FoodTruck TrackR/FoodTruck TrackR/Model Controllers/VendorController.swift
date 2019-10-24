//
//  VendorController.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/22/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation

class VendorController {

    var user: Any?
    var token: String?

    static let shared = VendorController()

    func register(user: VendorSignup, completion: @escaping(NetworkError?) -> Void) {
        let requestURL = baseURL
                        .appendingPathComponent("Vendor")
                        .appendingPathComponent(user.username)
                        .appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonEncoder = JSONEncoder()
        do {
            let vendorRep = VendorRepresentation(username: user.username, password: user.password, email: user.email, ownedTrucks: [], identifier: UUID())
            request.httpBody = try jsonEncoder.encode(vendorRep)
        } catch {
            print("Error encoding user: \(error)")
            completion(.encodingError)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 201 {
                print(response.statusCode)
                completion(.badResponse)
                return
            }

            if let error = error {
                NSLog("Error signing up: \(error)")
                completion(.otherError(error))
                return
            }

            guard let data = data else {
                completion(.noData)
                return
            }

            do {
                let result = try JSONDecoder().decode(VendorRepresentation.self, from: data)
                self.user = result
                self.token = user.password
                completion(nil)
            } catch {
                NSLog("Could not decode object: \(error)")
                completion(.badDecode)
            }
        }.resume()
    }

    func logIn(user: VendorLogin, completion: @escaping(NetworkError?) -> Void) {

        let requestURL = baseURL.appendingPathComponent("Vendor")
                                .appendingPathComponent(user.username)
                                .appendingPathExtension("json")
                                    

        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // request.httpBody = componentString?.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 201 && response.statusCode != 200 {
                NSLog("Response status code is not 200 or 201. Status code: \(response.statusCode)")
                completion(.badResponse)
                return
            }

            if let error = error {
                NSLog("Error verifying user: \(error)")
                completion(.otherError(error))
                return
            }

            guard let data = data else {
                NSLog("No data returned from data task")
                completion(.noData)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let result = try jsonDecoder.decode(VendorRepresentation.self, from: data)
                self.user = result
                self.token = result.password
                completion(nil)
                // TODO: Create new Background thread
//                let context = CoreDataStack.shared.mainContext
//
//                context.performAndWait {
//                    _ = Vendor(user: result) // TODO: create CoreData object from representation
//                }
//
//                self.saveToPersistentStore()
            } catch {
                NSLog("Error decoding data/token: \(error)")
                completion(.badDecode)
                return
            }
        }.resume()
    }


    func saveToPersistentStore() {
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
}

//class VendorController {
//	var user: Any?
//	var token: String?
//
//	static let shared = VendorController()
//
//	func register(user: VendorSignup, completion: @escaping(NetworkError?) -> Void) {
//		let requestURL = baseURL
//			.appendingPathComponent("api")
//			.appendingPathComponent("register")
//		var request = URLRequest(url: requestURL)
//		request.httpMethod = HTTPMethod.post.rawValue
//		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//		let jsonEncoder = JSONEncoder()
//		do {
//			request.httpBody = try jsonEncoder.encode(user)
//		} catch {
//			print("Error encoding user: \(error)")
//			completion(.encodingError)
//			return
//		}
//
//		URLSession.shared.dataTask(with: request) { (data, response, error) in
//			if let response = response as? HTTPURLResponse,
//				response.statusCode != 201 {
//				print(response.statusCode)
//				completion(.badResponse)
//				return
//			}
//
//			if let error = error {
//				NSLog("Error signing up: \(error)")
//				completion(.otherError(error))
//				return
//			}
//
//			guard let data = data else {
//				completion(.noData)
//				return
//			}
//
//			do {
//			//	let result = try JSONDecoder().decode(ReturnedVendor.self, from: data)
//
//			} catch {
//				NSLog("Could not decode object: \(error)")
//				completion(.badDecode)
//			}
//
//			completion(nil)
//		}.resume()
//	}
//
//	func logIn(user: VendorLogin, completion: @escaping(NetworkError?) -> Void) {
//		let requestURL = baseURL
//                        .appendingPathComponent("api")
//                        .appendingPathComponent("login")
//
//		var request = URLRequest(url: requestURL)
//		request.httpMethod = HTTPMethod.post.rawValue
//		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        do {
//            request.httpBody = try JSONEncoder().encode(user)
//        } catch {
//            NSLog("Error encoding userData: \(error)")
//            completion(.encodingError)
//            return
//        }
//
//		URLSession.shared.dataTask(with: request) { (data, response, error) in
//			if let response = response as? HTTPURLResponse,
//				response.statusCode != 201 && response.statusCode != 200 {
//				NSLog("Response status code is not 200 or 201. Status code: \(response.statusCode)")
//                completion(.badResponse)
//                return
//			}
//
//			if let error = error {
//				NSLog("Error verifying user: \(error)")
//				completion(.otherError(error))
//				return
//			}
//
//			guard let data = data else {
//				NSLog("No data returned from data task")
//				completion(.noData)
//				return
//			}
//
//			let jsonDecoder = JSONDecoder()
//			do {
//				let result = try jsonDecoder.decode(ReturnedLoginVendor.self, from: data)
//				self.token = result.password
//				self.user = user
//				// TODO: Create new Background thread
////  				let context = CoreDataStack.shared.mainContext
//
////				context.performAndWait {
////                   _ = Vendor(user: result) // TODO: create CoreData object from representation
////				}
////
////				self.saveToPersistentStore()
//				if self.token != nil {
//					completion(nil)
//				}
//			} catch {
//				NSLog("Error decoding data/token: \(error)")
//				completion(.badDecode)
//				return
//			}
//		}.resume()
//	}
//
//	func saveToPersistentStore() {
//		do {
//			try CoreDataStack.shared.mainContext.save()
//		} catch {
//			NSLog("Error saving managed object context: \(error)")
//		}
//	}
//}
