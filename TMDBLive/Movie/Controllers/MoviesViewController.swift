//
//  MoviesViewController.swift
//  TMDBLive
//
//  Created by Erwan Martin on 04/04/2022.
//

import UIKit
import SwiftUI

class MoviesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let cellReuseId: String = "MovieCellReuseId";
    
    let moviesViewModel: MoviesViewModel
    let genresViewModel: GenresViewModel
    
    init(moviesViewModel: MoviesViewModel, genresViewModel: GenresViewModel) {
        
        self.genresViewModel = genresViewModel;
        self.moviesViewModel = moviesViewModel;

        
        super.init(nibName: "MoviesViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = .red;
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self;
        tableView.delegate = self;
        
        tableView.separatorColor = .clear;
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellReuseId)
        
        self.genresViewModel.fetchGenres() {}
        
        self.moviesViewModel.fetchMovies() {
            self.tableView.reloadData()
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesViewModel.movies.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = (tableView.dequeueReusableCell(withIdentifier: cellReuseId) as? MovieTableViewCell) {
            
            cell.setupCell(
                title: moviesViewModel.movies[indexPath.item].title ?? "",
                subtitle: moviesViewModel.movies[indexPath.item].overview ?? "",
                imageURL: ApiViewModel.apiImgDomain + (moviesViewModel.movies[indexPath.item].poster_path ?? ""),
                duration: moviesViewModel.movies[indexPath.item].release_date ?? ""
            )
            return cell;
        }
        return UITableViewCell();
    }
    
    
}

extension MoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row;
        
        let videosViewModel: VideosViewModel = VideosViewModel();
        
        // Quand on clique sur un film, fait une requête pour trouver l'url de son trailer
        videosViewModel.fetchVideos(movie_id: moviesViewModel.movies[index].id ?? 0) { [self] in
            let hostVC = UIHostingController(rootView: MovieDetailsView(
                title: moviesViewModel.movies[index].title ?? "",
                length: moviesViewModel.movies[index].release_date ?? "",
                tags: moviesViewModel.movies[index].genre_ids ?? [0],
                description: moviesViewModel.movies[index].overview ?? "",
                notation: Float(moviesViewModel.movies[index].vote_average ?? 0),
                imageURL: ApiViewModel.apiImgDomain + (moviesViewModel.movies[index].poster_path ?? "") ,
                trailerURL: "https://youtu.be/" + videosViewModel.videos[0].key,
                moviesViewModel: moviesViewModel,
                genresViewModel: genresViewModel
            ));
            present(hostVC, animated: true);
        }
        
//        navigationController?.pushViewController(hostVC, animated: true);
    }
}
