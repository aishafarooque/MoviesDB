//
//  DetailViewController.swift
//  MoviesDB
//
//  Created by Aisha Farooque on 3/27/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var data: Displayable?
    var listData: [Displayable] = []
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imdbButton: UIButton!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    private func commonInit() {
        guard let data = data else { return }
        
        titleLabel.text = data.titleLabelText
        subtitleLabel.text = data.yearLabelText
        imdbButton.addTarget(self, action: #selector(openInIMDbClicked(_:)), for: .touchUpInside)
        
        let imageURL = URL(string: data.posterURLLabelText)
        if let imageData = try? Data(contentsOf: imageURL!) {
            imageView.image = UIImage(data: imageData)
        }
        
        fetchMoreInformation()
    }
    
    func fetchMoreInformation() {
        print ("Fetching more information")
//        let networkManager = NetworkManager()
//        networkManager.getMovieDetailByIMDbID(imdbID: data!.imdbIDText)
        
        let networkManager = NetworkManager()
        networkManager.getMovieDetailByIMDbID(imdbID: data!.imdbIDText) { (d, fetched) in
            if (fetched) {
                self.plotLabel.text = d?.plotLabelText
                self.directorLabel.text = d?.directorLabelText
            } else {
//                let alert = UIAlertController(title: "Error", message: "An error occured. Please check your spelling or provide more information.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
            }
        }


    }
    
    @objc func openInIMDbClicked(_ guesture: UITapGestureRecognizer) {
//        print ("printing")
//        print (data!.imdbIDText)
        let imdbURL = "https://www.imdb.com/title/" + data!.imdbIDText + "/"
        guard let url = URL(string: imdbURL) else { return }
        UIApplication.shared.open(url)
    }
}

//extension DetailViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
//        cell.textLabel?.text = listData[indexPath.row].titleLabelText
//        return cell
//    }
//}
