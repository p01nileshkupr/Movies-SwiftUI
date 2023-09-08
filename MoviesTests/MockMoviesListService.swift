//
//  MockMoviesListService.swift
//  MoviesTests
//
//  Created by Nilesh Prajapati on 2023/09/06.
//

import Foundation

class MockMoviesListService: MoviesListServiceProtocol {
    
    //MARK: - Properties

    private(set) var mockData: [MovieModel]
    private(set) var networkError: NetworkError?
    private(set) var isEmptyResponse: Bool = false

    //MARK: - init

    init(mockData: [MovieModel] = [],
         networkError: NetworkError? = nil) {
        self.mockData = mockData
        self.networkError = networkError
     }
    
    //MARK: - Protocol Methods

    func fetchMovies() async throws -> [MovieModel] {
        if let networkError = networkError {
            self.isEmptyResponse = true
            throw networkError
        } else if self.mockData.isEmpty {
            self.isEmptyResponse = true
            return self.mockData
        } else {
            return self.mockData
        }
    }
    
    //MARK: - deinit
    
    deinit {
        mockData.removeAll()
        networkError = nil
    }
}
