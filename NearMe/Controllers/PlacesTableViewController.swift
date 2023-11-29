//
//  PlacesTableViewController.swift
//  NearMe
//
//  Created by Ryan Gallagher on 29/11/2023.
//

import Foundation
import UIKit
import MapKit

class PlacesTableViewController: UITableViewController {
    var userLocation: CLLocation
    let places: ([PlaceAnnotation])
    
    init(userLocation: CLLocation, places: [PlaceAnnotation]) {
        self.userLocation = userLocation
        self.places = places
        super.init(nibName: nil, bundle: nil)
        
        //register tableviewcell
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PlaceCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //number of rows in section
        places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //returns individual cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        let place = places[indexPath.row]
        
        //cell config
        var content = cell.defaultContentConfiguration()
        content.text = place.name
        content.secondaryText = formatDistanceForDisplay(calculateDistance(from: userLocation, to: place.location))
        cell.contentConfiguration = content
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func calculateDistance(from: CLLocation, to: CLLocation) -> CLLocationDistance {
        from.distance(from: to)
    }
    
    private func formatDistanceForDisplay(_ distance: CLLocationDistance) -> String {
        let metres = Measurement(value: distance, unit: UnitLength.meters)
        return metres.converted(to: .miles).formatted()
    }
}
