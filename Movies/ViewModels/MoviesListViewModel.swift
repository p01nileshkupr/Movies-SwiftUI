//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Nilesh Prajapati on 2023/09/01.
//

import Foundation
import SwiftUI

enum SortBy {
    case title
    case rating
    case rank
}

class MoviesListViewModel: ObservableObject {

    //MARK: - Properties
    
    private var service: MoviesListServiceProtocol?
    private var movies: [MovieViewModel]? {
        didSet {
            setSearchResults()
        }
    }

    var searchText: String = "" {
        didSet {
            setSearchResults()
        }
    }
    var sortBy: SortBy {
        didSet {
            if sortBy == .rank {
                searchResults = searchResults?.sorted(by: {$0.rank < $1.rank})
            } else if sortBy == .title {
                searchResults = searchResults?.sorted(by: {$0.title < $1.title})
            } else {
                searchResults = searchResults?.sorted(by: {$0.rating < $1.rating})
            }
        }
    }

    @Published var searchResults: [MovieViewModel]?
    @Published var serviceState: NetworkServiceState
    @Published var networkError: NetworkError?

    //MARK: - init
    
    private init(serviceState: NetworkServiceState = .notyetstarted,
                 networkError: NetworkError? = nil,
                 sortType: SortBy = .rank) {
        self.serviceState = serviceState
        self.networkError = networkError
        self.sortBy = sortType
    }

    convenience init(service: MoviesListServiceProtocol) {
        self.init()
        self.service = service
    }
        
    //MARK: - Methods
    
    func setSearchResults() {
        guard !searchText.isEmpty else {
            self.searchResults = self.movies
            return
        }
        print("SearchText: \(searchText)")
        self.searchResults = movies?.filter({$0.title.contains(searchText)})
    }
    
    func setSort(by type: SortBy) {
        self.sortBy = type
    }
    
    //MARK: - Service calls
    
    @MainActor
    func fetchMovies() async {
        serviceState = .inprogress

        do {
            let list = try await service?.fetchMovies().compactMap({MovieViewModel(movieModel: $0)})
            serviceState = .succeed
            self.movies = list
        } catch {
            serviceState = .failed
            networkError = error as? NetworkError
        }
    }
    
    //MARK: - deinit
    
    deinit {
        service = nil
        movies?.removeAll()
        movies = nil
        networkError = nil
        searchResults?.removeAll()
        searchResults = nil
    }
}
