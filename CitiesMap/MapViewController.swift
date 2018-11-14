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
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    var coordinate: CLLocationCoordinate2D? {
        didSet {
            mapVIew?.setCenter(coordinate!, animated: true)
            mapVIew?.setRegion(MKCoordinateRegion(center: coordinate!, span: span), animated: true)
        }
    }
    @IBOutlet weak var mapVIew: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if coordinate != nil {
            mapVIew.setCenter(coordinate!, animated: true)
            mapVIew.setRegion(MKCoordinateRegion(center: coordinate!, span: span), animated: true)
        }
    }
}

