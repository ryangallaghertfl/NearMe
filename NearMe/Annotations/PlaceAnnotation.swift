//
//  PlaceAnnotation.swift
//  NearMe
//
//  Created by Ryan Gallagher on 29/11/2023.
//

import Foundation
import MapKit

class PlaceAnnotation: MKPointAnnotation {
    
    let mapItem: MKMapItem
    let id = UUID()
    var isSelected: Bool = false
    
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
        super.init()
        self.coordinate = mapItem.placemark.coordinate //coordinate of the found place
    }
    
    var name: String {
        mapItem.name ?? ""
    }
    
    var phone: String {
        mapItem.phoneNumber ?? ""
    }
    
    var location: CLLocation {
        mapItem.placemark.location ?? CLLocation.default
    }
}
