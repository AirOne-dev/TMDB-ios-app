//
//  Video.swift
//  TMDBLive
//
//  Created by Erwan Martin on 16/05/2022.
//

import Foundation

struct Video: Decodable {
    var iso_639_1: String
    var iso_3166_1: String
    var name: String
    var key: String
    var site: String
    var size: Int
    var type: String
    var official: Bool
    var published_at: String
    var id: String
}

struct VideoResponse: Decodable {
    var id: Int
    var results: [Video]
}
