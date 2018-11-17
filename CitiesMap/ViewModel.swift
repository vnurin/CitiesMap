//
//  ViewModel.swift
//  CitiesMap
//
//  Created by Vahagn Nurijanyan on 2018-11-14.
//  Copyright © 2018 BABELONi INC. All rights reserved.
//

import Foundation

class ViewModel {
    //this isn't lazy because it will be required always in the launch time
    private var cities: [City]! = {
        let jsonPath = Bundle.main.path(forResource: "cities", ofType: "json")!
        let jsonURL = URL(fileURLWithPath: jsonPath)
        let jsonData = try! Data(contentsOf: jsonURL)//this will succeed for sure
        return try! JSONDecoder().decode([City].self, from: jsonData)
    }()
    //this isn't computed property for faster processing
    var shownCities: [City]
    
    init() {
        cities.sort()
        shownCities = cities
    }
    
    func numberOfRowsInSection() -> Int {
        return shownCities.count
    }
    
    func contentOfCell(for indexPath: IndexPath) -> (name: String, country: String) {
        return (shownCities[indexPath.row].name, shownCities[indexPath.row].country)
    }
    
    func updateShownCities(with prefix: String?, completion: (() -> ())?) {
        DispatchQueue.global(qos: .background).async {
            if let lowercasedSearch = prefix?.lowercased(), !lowercasedSearch.isEmpty {
                self.shownCities = self.cities.filter {
                    $0.name.lowercased().hasPrefix(lowercasedSearch)
                }
            }
            else {
                self.shownCities = self.cities
            }
            completion?()
        }
    }
}
