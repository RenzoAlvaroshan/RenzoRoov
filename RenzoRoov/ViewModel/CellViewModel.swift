//
//  CellViewModel.swift
//  RenzoRoov
//
//  Created by Renzo Alvaroshan on 06/10/22.
//

import Foundation

final class CellMovieViewModel {
    
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var imageURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")")!
    }
    
    var movieTitle: String {
        return movie.title!
    }
}
