//
//  ViewController.swift
//  CitiesMap
//
//  Created by Vahagn Nurijanyan on 2018-11-14.
//  Copyright © 2018 BABELONi INC. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    private let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    var coordinate: CLLocationCoordinate2D? {
        didSet {
            mapView?.setRegion(MKCoordinateRegion(center: coordinate!, span: span), animated: true)
        }
    }
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.isUserInteractionEnabled = true
            mapView.showsScale = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if coordinate != nil {
            mapView.setRegion(MKCoordinateRegion(center: coordinate!, span: span), animated: true)
        }
    }
}

