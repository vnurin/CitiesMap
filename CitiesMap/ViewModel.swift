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
    private let cities: [City]? = {
        guard let jsonPath = Bundle.main.path(forResource: "cities", ofType: "json") else {
            return nil
        }
        let jsonURL = URL(fileURLWithPath: jsonPath)
        let jsonData = try! Data(contentsOf: jsonURL)//this will succeed for sure
        return try? JSONDecoder().decode([City].self, from: jsonData)
    }()
    //this isn't computed property for faster processing
    var shownCities: [City]
    
    init() {
        shownCities = cities ?? []
        print(self.shownCities[2])
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
                self.shownCities = self.cities?.filter {
                    $0.name.lowercased().hasPrefix(lowercasedSearch)
                    }
                    .sorted {
                        $0 < $1
                    } ?? []
            }
            else {
                self.shownCities = self.cities?.sorted {
                    $0 < $1
                    } ?? []
            }
            completion?()
        }
    }
}
