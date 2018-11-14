//
//  CitiesMapTests.swift
//  CitiesMapTests
//
//  Created by Vahagn Nurijanyan on 2018-11-14.
//  Copyright © 2018 BABELONi INC. All rights reserved.
//

import XCTest
@testable import CitiesMap

class CitiesMapTests: XCTestCase {

    let viewModel = ViewModel()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUpdateShownCities() {
        viewModel.updateShownCities(with: "Perunov") {
            XCTAssertEqual(self.viewModel.shownCities.count, 1)
            XCTAssertEqual(self.viewModel.shownCities[0].name, "Perunovo")
        }
    }

    func testUpdateShownCitiesPerformance() {
        self.measure {
            viewModel.updateShownCities(with: "La", completion: nil)
        }
    }

}
