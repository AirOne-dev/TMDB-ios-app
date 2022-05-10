//
//  Movie.swift
//  TMDBLive
//
//  Created by Erwan Martin on 05/04/2022.
//

import Foundation

struct Movie: Decodable {
    var adult: Bool?;
    var backdrop_path: String?;
    var genre_ids : [Int]?;
    var id: Int?;
    var original_language: String?;
    var original_title: String?;
    var overview: String?;
    var popularity: Double?;
    var poster_path: String?;
    var release_date: String?;
    var title: String?;
    var video: Bool?;
    var vote_average: Double?;
    var vote_count: Int?;
}

struct MovieResponse: Decodable {
    var page: Int
    var results: [Movie]
    var total_pages: Int
    var total_results: Int
}
