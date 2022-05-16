//
//  VideosViewModel.swift
//  TMDBLive
//
//  Created by Erwan Martin on 16/05/2022.
//

import Foundation

import Foundation
import WebKit
import Combine

class VideosViewModel: ObservableObject {
    @Published var videos: [Video] = []
    
    private var task: AnyCancellable?
    
    private var tryFetchVideos: Int = 0
    func fetchVideos(movie_id: Int, completion: @escaping () -> ()) {
        let url = ApiViewModel.videoUrl.replacingOccurrences(of: "%movie_id%", with: String(movie_id));
        task = URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .map { return $0.data; }
            .decode(type: VideoResponse.self, decoder: JSONDecoder())
            .replaceError(with: VideoResponse(id: 0, results: []))
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .map { return $0.results as [Video] }
            .sink {
                if($0.isEmpty && self.tryFetchVideos < 3) {
                    self.task?.cancel()
                    self.tryFetchVideos += 1
                    self.fetchVideos(movie_id: movie_id) {
                        
                    }
                    return
                } else {
                    self.videos = $0
                    completion()

                }
            }
    }
}
