//
//  MapViewController.swift
//  FoodTruck TrackR
//
//  Created by Jordan Christensen on 10/20/19.
//  Copyright © 2019 FoodTruckTrackR. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var foodTruckSearchBar: UISearchBar!
    @IBOutlet weak var foodTruckMapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let searchResultsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        checkLocationServices()
        
        foodTruckSearchBar.showsCancelButton = false
        foodTruckSearchBar.delegate = self
        foodTruckSearchBar.resignFirstResponder()
        setupTableView()
    }
    
    private func setupViews() {
        view.backgroundColor = .background
        
        foodTruckSearchBar.barTintColor = .background
        
        tabBarController?.tabBar.barStyle = .default
        tabBarController?.tabBar.barTintColor = .background
        tabBarController?.tabBar.tintColor = .text
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.text]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.text]
    }
    
    private func setupTableView() {
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        
        searchResultsTableView.isHidden = true
        
        view.addSubview(searchResultsTableView)
        searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        searchResultsTableView.topAnchor.constraint(equalTo: foodTruckSearchBar.bottomAnchor).isActive = true
        searchResultsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchResultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        searchResultsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setupLocationManager() { // Housekeeping
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // We want the best accuracy
    }
    
    private func centerViewOnUser() { // Grabs users current location and centers map onto location with 10,000 meters in each direction as padding
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 10_000, longitudinalMeters: 10_000)
            foodTruckMapView.setRegion(region, animated: true)
        } else {
            NSLog("User appears to not have connection.")
        }
    }
    
    private func checkLocationServices() { // Check to make sure Location Services are active
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            locationManager.startUpdatingLocation()
        } else { // Alert user if Location Services are disabled and instruct on how to fix
            let alert = UIAlertController(title: "Location Services Disabled", message: "It looks like location services is disabled. Please enable it in settings.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { _ in
                if let url = URL(string: "App-Prefs:root=Privacy&path=LOCATION") {
                    // Open Location Services in settings if disabled
                    UIApplication.shared.open(url)
                } else if let url = URL(string: UIApplication.openSettingsURLString) {
                    // If Location Services url is changed in the future, open settings instead
                    UIApplication.shared.open(url)
                }
            }))
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func checkLocationAuthorization() { // Check to see if user has authorized location tracking in app
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse: // "Allow"
            foodTruckMapView.showsUserLocation = true // Only show location if user has allowed location tracking
            centerViewOnUser()
        case .denied: // "Don't Allow"
            let alert = UIAlertController(title: "Location Permissions Disabled", message: "It looks like location permission are disabled. Please enable them in settings.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        case .notDetermined: // User has not yet viewed location tracking prompt
            locationManager.requestWhenInUseAuthorization()
        case .restricted: // User has parental controls on
            let alert = UIAlertController(title: "Location is Restricted", message: "It looks like location permission are restricted!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        @unknown default: // Deal with any other case
            NSLog("Location services/permission status unknown. Please update to latest version of the app!")
            break
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

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Periodically updates to always show user their current location
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 10_000, longitudinalMeters: 10_000)
        foodTruckMapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Checks the auth status if it was changed
        checkLocationAuthorization()
    }
}

extension MapViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchResultsTableView.dequeueReusableCell(withIdentifier: "FoodTruckCell", for: indexPath) as? FoodTruckTableViewCell else { return UITableViewCell() }
        
        // Set up cell
        
        return cell
    }
    
    
}

extension MapViewController: UISearchBarDelegate {
    override func resignFirstResponder() -> Bool {
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            _ = searchBarShouldEndEditing(searchBar)
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        UIView.animate(withDuration: 0.2) {
            self.searchResultsTableView.isHidden = false
            searchBar.showsCancelButton = true
        }
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(false)
        //Send a fetch request to the back end
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.2) {
            
            self.searchResultsTableView.isHidden = true
            searchBar.showsCancelButton = false
        }
        
        searchBar.text = ""
        
        self.view.endEditing(true)
    }
    
}
