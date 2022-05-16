//
//  ApiViewModel.swift
//  TMDBLive
//
//  Created by Erwan Martin on 05/04/2022.
//

import Foundation
import WebKit

struct ApiViewModel {
    static var webView: WKWebView?;
    
    static var apiKey = "7fa30a1ef14d0d96ad208858302de410"
    
    static var apiDomain = "https://api.themoviedb.org"
    static var apiImgDomain = "https://image.tmdb.org/t/p/w500"
    static let discoverUrl = ApiViewModel.apiDomain +  "/3/discover/movie?api_key="+ApiViewModel.apiKey+"&language=fr-FR&sort_by=popularity.desc&include_video=true&with_watch_monetization_types=flatrate"
    static let genreUrl = ApiViewModel.apiDomain + "/3/genre/movie/list?api_key="+ApiViewModel.apiKey+"&language=fr-FR"
    static let videoUrl = ApiViewModel.apiDomain +
        "/3/movie/%movie_id%/videos?api_key="+ApiViewModel.apiKey+"&language=fr-FR"
}
