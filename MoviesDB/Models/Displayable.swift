//
//  Displayable.swift
//  MoviesDB
//
//  Created by Aisha Farooque on 3/23/21.
//

import Foundation

protocol Displayable {
    var titleLabelText: String { get }
    var imdbIDText: String { get }
//    var actorsLabelText: [String] { get }
    var directorLabelText: String? { get }
    var plotLabelText: String? { get }
    var posterURLLabelText: String { get }
    var yearLabelText: String { get }
}
