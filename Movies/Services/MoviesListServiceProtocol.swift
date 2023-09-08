//
//  MoviesListServiceProtocol.swift
//  Movies
//
//  Created by Nilesh Prajapati on 2023/09/01.
//

import Foundation

protocol MoviesListServiceProtocol {
    func fetchMovies() async throws -> [MovieModel]
}
