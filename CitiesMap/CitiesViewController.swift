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

    let viewModel = ViewModel()
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
            mapViewController.coordinate = CLLocationCoordinate2D(latitude: viewModel.shownCities[tableView.indexPathForSelectedRow!.row].coord.lat, longitude: viewModel.shownCities[tableView.indexPathForSelectedRow!.row].coord.lon)
        }
        else {
            performSegue(withIdentifier: "Show Map", sender: tableView.cellForRow(at: indexPath))
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Map" {
            if let mapViewController = segue.destination as? MapViewController {
                mapViewController.coordinate = CLLocationCoordinate2D(latitude: viewModel.shownCities[tableView.indexPathForSelectedRow!.row].coord.lat, longitude: viewModel.shownCities[tableView.indexPathForSelectedRow!.row].coord.lon)
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
