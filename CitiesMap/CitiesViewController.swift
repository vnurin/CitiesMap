//
//  CitiesViewController.swift
//  CitiesMap
//
//  Created by Vahagn Nurijanyan on 2018-11-14.
//  Copyright © 2018 BABELONi INC. All rights reserved.
//

import UIKit
import CoreLocation

class CitiesViewController: UITableViewController {

    private let viewModel = ViewModel()
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.addTarget(self, action: #selector(search), for: .editingChanged)
        }
    }
    
    @objc func search() {
        viewModel.updateShownCities(with: searchTextField.text) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
        tableView.scrollsToTop = true
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "City", for: indexPath)

        let (name, country) = viewModel.contentOfCell(for: indexPath)
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = country
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let mapViewController = splitViewController?.viewControllers.last as? MapViewController {
            mapViewController.coordinate = CLLocationCoordinate2D(latitude: viewModel.shownCities[indexPath.row].coord.lat, longitude: viewModel.shownCities[indexPath.row].coord.lon)
        }
        else {
            performSegue(withIdentifier: "Show Map", sender: viewModel.shownCities[indexPath.row].coord)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Map" {
            if let mapViewController = segue.destination as? MapViewController, let coord = sender as? Coord {
                mapViewController.coordinate = CLLocationCoordinate2D(latitude: coord.lat, longitude: coord.lon)
            }
        }
    }
}

extension CitiesViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

extension CitiesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}
