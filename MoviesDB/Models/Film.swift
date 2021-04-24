//
//  Film.swift
//  MoviesDB
//
//  Created by Aisha Farooque on 3/23/21.
//

import Foundation

/// Defines the data properties and coding keys to be pulled from the API response
/// The struct is decodable to turn the JSON into a data model
struct Film: Decodable {
    let title: String
    let imdbID: String
//    let actors: [String]
    let director: String?
    let plot: String?
    let posterURL: String
    let year: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case imdbID = "imdbID"
//        case actors = "Actors"
        case director = "Director"
        case plot = "Plot"
        case posterURL = "Poster"
        case year = "Year"
    }
}

/// This extension allows the detailed information display’s view controller to get the correct labels and values for a film from the model itself.
extension Film: Displayable {
    var titleLabelText: String { title }
    var imdbIDText: String { imdbID }
//    var actorsLabelText: [String] { actors }
    var directorLabelText: String? { "Director: " + director! }
    var plotLabelText: String? { plot }
    var posterURLLabelText: String { posterURL }
    var yearLabelText: String { year }
}
