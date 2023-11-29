//
//  ViewController.swift
//  NearMe
//
//  Created by Ryan Gallagher on 27/11/2023.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    var locationManager: CLLocationManager?
    
    let defaultLocation = CLLocation(latitude: 51.500800, longitude: 0.005650) //Greenwich, London
    
    lazy var mapView: MKMapView = {
        return setUpMapView()
    }()
    
    lazy var searchTextField: UITextField = {
        return setUpSearchTextField()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestLocation()
        
        setupUI()
    }
    
}

//MARK: extracted private functions

extension ViewController {
    
//MARK: setup properties
    private func setUpSearchTextField() -> UITextField {
        let searchTextField = UITextField()
        searchTextField.delegate = self
        searchTextField.layer.cornerRadius = 10
        searchTextField.clipsToBounds = true
        searchTextField.backgroundColor = UIColor.white
        searchTextField.placeholder = "Search"
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0)) //leftview manages the appearance of a view on the left side of text field - this applies a margin for the cursor
        searchTextField.leftViewMode = .always
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        return searchTextField
    }
    
    private func setUpMapView() -> MKMapView {
        let map = MKMapView()
        map.delegate = self
        map.translatesAutoresizingMaskIntoConstraints = false
        map.showsUserLocation = true
        return map
    }
    
//MARK: setup constraints on subviews
    private func setupUI() {
        
        view.addSubview(searchTextField)
        view.addSubview(mapView)
        
        view.bringSubviewToFront(searchTextField)
        
        //add constraints to searchtextfield
        
        searchTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchTextField.widthAnchor.constraint(equalToConstant: view.bounds.size.width/1.2).isActive = true
        searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        searchTextField.returnKeyType = .go
        
        //add constraints to mapView
        
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

//MARK: handling authorisation status
    
    private func checkLocationAuthorisation() {
        guard let locationManager = locationManager,
              let location = locationManager.location else {return}
        //location = defaultLocation //for testing only, default to Greenwich
   
        
        switch locationManager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1609, longitudinalMeters: 1609)
                mapView.setRegion(region, animated: true)
            case .denied:
                print("Location services denied")
            case .notDetermined, .restricted:
                print("Location services cannot be determined or is restricted")
            @unknown default:
                print("Unknown error. Unable to get location.")
        }
        
        print("MapView region is: \(mapView.region)")
    }
    
    
//MARK: presentPlacesSheet is called by textFieldShouldReturn in VC implementing UITextFieldDelegate
    
    private func presentPlacesSheet(places: [PlaceAnnotation]) {
        
        guard let locationManager = locationManager,
              let userLocation = locationManager.location
        else {return}
        
        let placesTVC = PlacesTableViewController(userLocation: userLocation, places: places)
        placesTVC.modalPresentationStyle = .pageSheet
        
        if let sheet = placesTVC.sheetPresentationController {
            sheet.prefersGrabberVisible = true //coming from bottom
            sheet.detents = [.medium(), .large()] //display in multiple formats
            present(placesTVC, animated: true)
        }
    }

//MARK: making request to MKLocalSearch API and handling responses
    
    private func findNearbyPlaces(by query: String) {
        //clear all pins
        mapView.removeAnnotations(mapView.annotations)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let response = response, error == nil else {return}
            
            let places = response.mapItems.map(PlaceAnnotation.init) //parse items into PlaceAnnotation model
            places.forEach { place in
                self?.mapView.addAnnotation(place) //to avoid circular referencing, optional self and weak self
            }
            self?.presentPlacesSheet(places: places)
        }
    
    }
    
}

//MARK: conforming to CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorisation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

//MARK: Conform to UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        if !text.isEmpty {
            textField.resignFirstResponder() //makes sure that the keyboard goes away
            //find nearby places
            findNearbyPlaces(by: text)
        }
        return true
    }
    
}

//MARK: Conform to MKMapViewDelegate for selecting map items

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        guard let placeAnnotation = annotation as? PlaceAnnotation else {return}
        
        
    }
    
}
