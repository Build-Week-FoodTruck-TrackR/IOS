//
//  VendorController.swift
//  FoodTruck TrackR
//
//  Created by Percy Ngan on 10/22/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth


class VendorController {
    let ref = Database.database().reference()
    var user: VendorRepresentation?
    var token: String?

    static let shared = VendorController()

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
            db.collection("vendors").addDocument(data: ["username":username, "firstName":firstName, "lastName":lastName, "uid":result.user.uid]) { error in
                if let error = error {
                    completion(.otherError(error))
                    return
                }
                
            }
        }
    }
    
    func logOut() {
        user = nil
        token = nil
    }

    func logIn(username: String, password: String, completion: @escaping(NetworkError?) -> Void) {
        ref.child("Vendor/\(username)").observeSingleEvent(of: .value) { dataSnapshot in
            let jsonDecoder = JSONDecoder()
            guard let dictionary = dataSnapshot.value as? [String:Any] else {
                completion(.badResponse)
                return
            }
            do {
                let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
                self.user = try jsonDecoder.decode(VendorRepresentation.self, from: data)
                self.token = "" // MARK: - Set Token
                completion(nil)
            } catch {
                NSLog("\(#file):L\(#line): Configuration failed inside \(#function) with error: \(error)")
            }
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
