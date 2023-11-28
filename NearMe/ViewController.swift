//
//  ViewController.swift
//  NearMe
//
//  Created by Ryan Gallagher on 27/11/2023.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.showsUserLocation = true
        return map
    }()
    
    lazy var searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.layer.cornerRadius = 10
        searchTextField.clipsToBounds = true
        searchTextField.backgroundColor = UIColor.white
        searchTextField.placeholder = "Search"
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)) //leftview manages the appearance of a view on the left side of text field
        searchTextField.leftViewMode = .always
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        return searchTextField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        view.addSubview(mapView)
        
        //add constraints to mapView
        
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }


}

