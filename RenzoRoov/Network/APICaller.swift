//
//  APICaller.swift
//  RenzoRoov
//
//  Created by Renzo Alvaroshan on 04/10/22.
//

import Foundation
import Alamofire

struct Constants {
    static let API_KEY = "82d755c4d1db25ea38bc0943dea7764c"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    
    static func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: MovieResponse.self) { response in
                guard let movies = response.value else { return }
                completion(.success(movies.results))
            }
    }
}
