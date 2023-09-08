//
//  MovieListService.swift
//  Movies
//
//  Created by Nilesh Prajapati on 2023/09/01.
//

import Foundation

class MovieListService: MovieListServiceProtocol {
    
    func fetchMovies() async throws -> [MovieModel] {
        let resource = RequestConfig.Resource<[MovieModel]>(method: .get) { data in
            return MovieModel.decodedList(data)
        }

        let result = await NetworkManager.sharedNetworkManager.fetchData(resource: resource)
        switch result {
            case .success(let list):
                return list
            case .failure(let error):
                throw error
        }
    }
}
