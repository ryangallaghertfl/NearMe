//
//  PlaceDetailViewController.swift
//  NearMe
//
//  Created by Ryan Gallagher on 29/11/2023.
//

import Foundation
import UIKit

class PlaceDetailViewController: UIViewController {
    
    let place: PlaceAnnotation
    
    init(place: PlaceAnnotation) {
        self.place = place
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    
    //MARK: setting up UI
    
    private func setupUI() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
