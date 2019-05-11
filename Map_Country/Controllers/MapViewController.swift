//
//  MapViewController.swift
//  Map_Country
//
//  Created by Nikita Gura on 5/8/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    //MARK: Variables
    private lazy var mapView = MKMapView()
    private lazy var backButton = UIButton()
    private var country: Country?
    
    init(country: Country){
        super.init(nibName: nil, bundle: nil)
        self.country = country
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupMapView()
        setupBackButton()
        view.addSubview(mapView)
        view.addSubview(backButton)
        setupLayout()
        
    }
    
    //MARK: Methods
    
    private func setupBackButton(){
        backButton.setTitle("Back", for: .normal)
        backButton.layer.cornerRadius = 0.5 * 100
        backButton.backgroundColor = .red
        backButton.addTarget(self, action: #selector(dismissBack), for: .touchUpInside)
    }
    
    private func setupMapView(){
        guard let country = country else {return}
        let locCountry = CLLocation(latitude: country.latlng[0], longitude: country.latlng[1])
        let regionRadios =  sqrt(country.area ?? 10) * 2000
        let region = MKCoordinateRegion(center: locCountry.coordinate, latitudinalMeters: regionRadios, longitudinalMeters: regionRadios)
        mapView.setRegion(region, animated: true)
    }
    
    private func setupLayout(){
        mapView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            backButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 100)
            ])
    }
    
    //MARK: Selectors
    
    @objc func dismissBack(){
        dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
