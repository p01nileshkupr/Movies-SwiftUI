//
//  MoviesListRowViewModel.swift
//  Movies
//
//  Created by Nilesh Prajapati on 2023/09/04.
//

import Foundation

struct MoviesListRowViewModel {
    let movie: MovieViewModel
    
    var image: String {
        movie.image
    }
    
    var title: String {
        movie.title
    }
        
    var rating: String {
        movie.rating
    }
    
    var year: String {
        movie.year
    }

    var rank: Int {
        movie.rank
    }
}
