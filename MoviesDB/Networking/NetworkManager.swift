//
//  NetworkManager.swift
//  MoviesDB
//
//  Created by Aisha Farooque on 3/23/21.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class NetworkManager {

    let clientID: String = "3fa6980"
    
    func getMovie (_ searchText: String, completionHandler: @escaping (Films?, Bool) -> () ) {
        
        print ("Fetching films.")
        let url: String = "http://www.omdbapi.com/?apikey=3fa6980&s="
        var requestURL = url + searchText
        requestURL = requestURL.replacingOccurrences(of: " ", with: "%20")
//        print (request)
        
        /// Validate will ensure that the response returned is an HTTP response code between 200-299
        AF.request(requestURL)
            .validate()
            .responseDecodable(of: Films.self) { (response) in
                switch response.result {
                case .success(_):
                    completionHandler(response.value!, true)
                    print ("Films fetched.")
                case .failure(_):
                    print ("Encountered error \(response.error)")
                    completionHandler(response.value, false)
                }
            }
    }
    
    func getMovieDetailByIMDbID(imdbID: String, completionHandler: @escaping (Film?, Bool) -> () ) {
        print ("Fetching film by IMDb title")

        var requestURL = "http://www.omdbapi.com/?apikey=3fa6980&i=" + imdbID
        requestURL = requestURL.replacingOccurrences(of: " ", with: "%20")
        /*let request = AF.request(requestURL)

        request.responseJSON { (response) in
                switch response.result {
                case .success(_):
//                    completionHandler(response.value!, true)
                    print ("Films fetched.")
//                    print (response.value)

                case .failure(_):
                    print ("Encountered error \(response.error)")
//                    completionHandler(response.value, false)
                }
            }*/
        
        AF.request(requestURL)
            .validate()
            .responseDecodable(of: Film.self) { (response) in
                switch response.result {
                case .success(_):
                    print ("Films fetched.")
                    print (response.value)
                    completionHandler(response.value, true)
                case .failure(_):
                    print ("Encountered error \(response.error)")
                    completionHandler(response.value, false)
                }
            }

    }
}
