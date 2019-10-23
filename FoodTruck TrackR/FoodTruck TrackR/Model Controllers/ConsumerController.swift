//
//  ConsumerController.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/22/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation

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

let baseURL = URL(string: "https://foodtruck-2271c.firebaseio.com/")!

class ConsumerController {

    var user: Any?
    var token: String?

    static let shared = ConsumerController()

    func register(user: ConsumerSignup, completion: @escaping(NetworkError?) -> Void) {
        let requestURL = baseURL
                        .appendingPathComponent("Consumer")
                        .appendingPathComponent(user.username)
                        .appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonEncoder = JSONEncoder()
        do {
            let consumerRep = ConsumerRepresentation(username: user.username, password: user.password, email: user.email, currentLocation: LocationRepresentaion(longitute: 0, latitude: 0), favoriteTrucks: [], identifier: UUID())
            request.httpBody = try jsonEncoder.encode(consumerRep)
        } catch {
            print("Error encoding user: \(error)")
            completion(.encodingError)
            return
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
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
                let result = try JSONDecoder().decode(ConsumerRepresentation.self, from: data)
                self.user = result
                self.token = result.password
                completion(nil)
            } catch {
                NSLog("Could not decode object: \(error)")
                completion(.badDecode)
            }
        }.resume()
    }

    func logIn(user: ConsumerLogin, completion: @escaping(NetworkError?) -> Void) {

        let requestURL = baseURL.appendingPathComponent("Consumer")
                                .appendingPathComponent(user.username)
                                .appendingPathExtension("json")
                                    

        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // request.httpBody = componentString?.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
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
                let result = try jsonDecoder.decode(ConsumerRepresentation.self, from: data)
                self.user = result
                self.token = result.password
                completion(nil)
                // TODO: Create new Background thread
//                let context = CoreDataStack.shared.mainContext
//
//                context.performAndWait {
//                    _ = Consumer(user: result) // TODO: create CoreData object from representation
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
    
    func updateLocation(longitute: Double, latitude: Double) {
        let location = LocationRepresentaion(longitute: longitute, latitude: latitude)
        
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



//let baseURL = URL(string: "https://food-truck-finder-rj.herokuapp.com/")!
//
//class ConsumerController {
//
//	var user: Any?
//	var token: String?
//
//	static let shared = ConsumerController()
//
//	func register(user: ConsumerSignup, completion: @escaping(NetworkError?) -> Void) {
//		let requestURL = baseURL
//			.appendingPathComponent("api")
//			.appendingPathComponent("register")
//
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
//				let result = try JSONDecoder().decode(ReturnedConsumer.self, from: data)
//				self.token = result.token
//			} catch {
//				NSLog("Could not decode object: \(error)")
//				completion(.badDecode)
//			}
//
//			completion(nil)
//		}.resume()
//	}
//
//	func logIn(user: ConsumerLogin, completion: @escaping(NetworkError?) -> Void) {
//
//		let requestURL = baseURL.appendingPathComponent(user.username)
//
//		var urlComponents = URLComponents(url: requestURL, resolvingAgainstBaseURL: true)
//		let grantTypeQuery = URLQueryItem(name: "grant_type", value: "password")
//		let usernameQuery = URLQueryItem(name: "username", value: "\(user.username)")
//		let passwordQuery = URLQueryItem(name: "password", value: "\(user.password)")
//		urlComponents?.queryItems = [grantTypeQuery, usernameQuery, passwordQuery]
//
//		guard let url = urlComponents?.url else {
//			completion(.invalidInput)
//			return
//		}
//		var request = URLRequest(url: url)
//		request.httpMethod = HTTPMethod.post.rawValue
//		request.setValue("basic bGFtYmRhLWNsaWVudDpsYW1iZGEtc2VjcmV0", forHTTPHeaderField: "Authorization")
//		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
//		// request.httpBody = componentString?.data(using: .utf8)
//
//		let jsonEncoder = JSONEncoder()
//		do {
//			let userData = try jsonEncoder.encode(user)
//			request.httpBody = userData
//		} catch {
//			NSLog("Error encoding userData: \(error)")
//		}
//
//		URLSession.shared.dataTask(with: request) { (data, response, error) in
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
//			let jsonDecoder = JSONDecoder()
//			do {
//				let result = try jsonDecoder.decode(ReturnedLoginConsumer.self, from: data)
//				self.token = result.password
//				self.user = user
//				// TODO: Create new Background thread
////				let context = CoreDataStack.shared.mainContext
//
////				context.performAndWait {
////					_ = Consumer(user: result) // TODO: create CoreData object from representation
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
//
//	func saveToPersistentStore() {
//		do {
//			try CoreDataStack.shared.mainContext.save()
//		} catch {
//			NSLog("Error saving managed object context: \(error)")
//		}
//	}
//}
