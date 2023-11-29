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
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    
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
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20) //it's not touching edges of screen
        
        nameLabel.text = place.name
        
        stackView.addArrangedSubview(nameLabel)
        
        nameLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
        
        view.addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
