//
//  MoviesService.swift
//  SwiftWars
//
//  Created by v.prusakov on 3/2/20.
//  Copyright © 2020 AO Tinkoff. All rights reserved.
//

import Combine
import Foundation

class MoviesService {
    
    static var shared: MoviesService = MoviesService()
    
    let baseURL = URL(string: "https://api.themoviedb.org/3")!
    let apiKey = "1d9b898a212ea52e283351e521e17871"
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func getPopularMovies() -> AnyPublisher<[Movie], Error> {
        let queryURL = baseURL.appendingPathComponent("movie/now_playing")
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [
           URLQueryItem(name: "api_key", value: apiKey),
           URLQueryItem(name: "language", value: Locale.preferredLanguages[0])
        ]
        
        var req = URLRequest(url: components.url!)
        req.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: req)
            .map { $0.data }
            .decode(type: MovieResponse.self, decoder: self.decoder)
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

struct MovieResponse: Decodable {
    let results: [Movie]
}
