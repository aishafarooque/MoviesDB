//
//  ViewController.swift
//  MoviesDB
//
//  Created by Aisha Farooque on 3/23/21.
//

import UIKit
import Alamofire

class ViewController: UITableViewController {
    
    // Property to store the array of information you get back from the server.
    var films: [Film] = []
    var items: [Displayable] = []
    var selectedItem: Displayable?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        fetchFilm(title: "high")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.titleLabelText
        cell.detailTextLabel?.text = item.yearLabelText
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = items[indexPath.row]
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? DetailViewController else {
            return
        }
        
        destinationVC.data = selectedItem
        destinationVC.listData = items
    }

}

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        items = films
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let movieTitle = searchBar.text else { return }
        searchBar.resignFirstResponder()
        searchBar.text = nil
        fetchFilm(title: movieTitle)
    }
    
}

extension ViewController {

    func fetchFilm(title: String) {
        let networkManager = NetworkManager()
        networkManager.getMovie(title) { (d, fetched) in
            if (fetched) {
                self.films = d!.all
                self.items = d!.all
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Error", message: "An error occured. Please check your spelling or provide more information.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
