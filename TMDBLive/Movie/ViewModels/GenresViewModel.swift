//
//  GenresViewModel.swift
//  TMDBLive
//
//  Created by Erwan Martin on 05/04/2022.
//

import Foundation
import WebKit
import Combine

class GenresViewModel: ObservableObject {
    @Published var genres: [Genre] = []
    
    private var task: AnyCancellable?
    
    private var tryFetchGenres: Int = 0
    func fetchGenres() {
        task = URLSession.shared.dataTaskPublisher(for: URL(string: ApiViewModel.genreUrl)!)
            .map { return $0.data; }
            .decode(type: GenreResponse.self, decoder: JSONDecoder())
            .replaceError(with: GenreResponse(genres: []))
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .map { return $0.genres as [Genre] }
            .sink {
                if($0.isEmpty && self.tryFetchGenres < 3) {
                    self.task?.cancel()
                    self.tryFetchGenres += 1
                    self.fetchGenres()
                    return
                } else {
                    self.genres = $0
                }
            }
    }
}
