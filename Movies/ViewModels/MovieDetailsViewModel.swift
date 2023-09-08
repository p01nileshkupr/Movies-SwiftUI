//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Nilesh Prajapati on 2023/09/01.
//

import Foundation

struct MovieDetailsViewModel {
    let selectedMovie: MovieViewModel
    
    var image: String {
        selectedMovie.image
    }
    
    var title: String {
        selectedMovie.title
    }
    
    var description: String {
        selectedMovie.description
    }

    var year: String {
        selectedMovie.year
    }
    
    var genre: String {
        selectedMovie.genre
    }

    var rank: Int {
        selectedMovie.rank
    }
}
