//
//  UserController.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/19/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

let baseURL = URL(string: "https://food-truck-finder-rj.herokuapp.com/")!

class UserController {
    var user: Any?
    
    var token: String?
    
    static let shared = UserController()
    
    func signUpVendor(user: VendorSignup, completion: @escaping() -> Void) {
        let requestURL = baseURL.appendingPathComponent(user.username)
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            request.httpBody = try jsonEncoder.encode(user)
        } catch {
            print("Error encoding user: \(error)")
            completion()
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 201 {
                print(response.statusCode)
                completion()
                return
            }
            
            if let error = error {
                NSLog("Error signing up: \(error)")
                completion()
                return
            }
            
            completion()
        }.resume()
    }
    
    func signUpVendor(user: ConsumerSignup, completion: @escaping() -> Void) {
        let requestURL = baseURL.appendingPathComponent(user.username)
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            request.httpBody = try jsonEncoder.encode(user)
        } catch {
            print("Error encoding user: \(error)")
            completion()
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 201 {
                print(response.statusCode)
                completion()
                return
            }
            
            if let error = error {
                NSLog("Error signing up: \(error)")
                completion()
                return
            }
            
            completion()
        }.resume()
    }
    
    
    func logIn(user: Any, completion: @escaping() -> Void) {
        
        if let user = user as? VendorLogin {
            let requestURL = baseURL.appendingPathComponent(user.username)
            
            var urlComponents = URLComponents(url: requestURL, resolvingAgainstBaseURL: true)
            let grantTypeQuery = URLQueryItem(name: "grant_type", value: "password")
            let usernameQuery = URLQueryItem(name: "username", value: "\(user.username)")
            let passwordQuery = URLQueryItem(name: "password", value: "\(user.password)")
            urlComponents?.queryItems = [grantTypeQuery, usernameQuery, passwordQuery]
            
            guard let url = urlComponents?.url else {
                completion()
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("basic bGFtYmRhLWNsaWVudDpsYW1iZGEtc2VjcmV0", forHTTPHeaderField: "Authorization")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            // request.httpBody = componentString?.data(using: .utf8)
            
            let jsonEncoder = JSONEncoder()
            do {
                let userData = try jsonEncoder.encode(user)
                request.httpBody = userData
            } catch {
                NSLog("Error encoding userData: \(error)")
            }
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse,
                    response.statusCode != 200 {
                    NSLog("Response status code is not 200. Status code: \(response.statusCode)")
                }
                
                if let error = error {
                    NSLog("Error verifying user: \(error)")
                    completion()
                    return
                }
                
                guard let data = data else {
                    NSLog("No data returned from data task")
                    completion()
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let result = try jsonDecoder.decode(VendorRepresentation.self, from: data)
                    self.token = result.password
                    self.user = user
                    // TODO: Create new Background thread
                    let context = CoreDataStack.shared.mainContext
                    
                    context.performAndWait {
                        _ = Vendor(user: result)
                    }
                    
                    self.saveToPersistentStore()
                    if self.token != nil {
                        completion()
                    }
                } catch {
                    NSLog("Error decoding data/token: \(error)")
                    completion()
                    return
                }
            }.resume()
        } else if let user = user as? ConsumerLogin {
            let requestURL = baseURL.appendingPathComponent(user.username)
            
            var urlComponents = URLComponents(url: requestURL, resolvingAgainstBaseURL: true)
            let grantTypeQuery = URLQueryItem(name: "grant_type", value: "password")
            let usernameQuery = URLQueryItem(name: "username", value: "\(user.username)")
            let passwordQuery = URLQueryItem(name: "password", value: "\(user.password)")
            urlComponents?.queryItems = [grantTypeQuery, usernameQuery, passwordQuery]
            
            guard let url = urlComponents?.url else {
                completion()
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("basic bGFtYmRhLWNsaWVudDpsYW1iZGEtc2VjcmV0", forHTTPHeaderField: "Authorization")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            // request.httpBody = componentString?.data(using: .utf8)
            
            let jsonEncoder = JSONEncoder()
            do {
                let userData = try jsonEncoder.encode(user)
                request.httpBody = userData
            } catch {
                NSLog("Error encoding userData: \(error)")
            }
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse,
                    response.statusCode != 200 {
                    NSLog("Response status code is not 200. Status code: \(response.statusCode)")
                }
                
                if let error = error {
                    NSLog("Error verifying user: \(error)")
                    completion()
                    return
                }
                
                guard let data = data else {
                    NSLog("No data returned from data task")
                    completion()
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let result = try jsonDecoder.decode(ConsumerRepresentation.self, from: data)
                    self.token = result.password
                    self.user = user
                    // TODO: Create new Background thread
                    let context = CoreDataStack.shared.mainContext
                    
                    context.performAndWait {
                        _ = Consumer(user: result)
                    }
                    
                    self.saveToPersistentStore()
                    if self.token != nil {
                        completion()
                    }
                } catch {
                    NSLog("Error decoding data/token: \(error)")
                    completion()
                    return
                }
            }.resume()
        }
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
}
