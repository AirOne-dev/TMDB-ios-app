//
//  Genre.swift
//  TMDBLive
//
//  Created by Erwan Martin on 05/04/2022.
//

import Foundation

struct Genre: Decodable {
    var id: Int
    var name: String
}

struct GenreResponse: Decodable {
    var genres: [Genre]
}
