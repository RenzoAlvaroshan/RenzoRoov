//
//  MovieViewModel.swift
//  RenzoRoov
//
//  Created by Renzo Alvaroshan on 04/10/22.
//

import Foundation
import RxSwift
import RxCocoa

struct MovieViewModel {
    private let _movies = BehaviorRelay<[Movie]>(value: [])
    
    var movies: Driver<[Movie]> {
        return _movies.asDriver()
    }
    
    var moviesNotDriver: [Movie] {
        return _movies.value
    }
    
    var numberOfMovies: Int {
        return _movies.value.count
    }
    
    init() {
        fetchMovies()
    }
    
    func viewModelForCell(at index: Int) -> CellMovieViewModel? {
        guard index < _movies.value.count else { return nil }
        
        return CellMovieViewModel(movie: _movies.value[index])
    }
    
    private func fetchMovies() {
        self._movies.accept([])
        
        APICaller.getPopularMovies { result in
            switch result {
            case .success(let movies):
                self._movies.accept(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
