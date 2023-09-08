//
//  MovieViewModel.swift
//  Movies
//
//  Created by Nilesh Prajapati on 2023/09/01.
//

import Foundation

struct MovieViewModel: Identifiable {
    let movieModel: MovieModel
    
    init(movieModel: MovieModel) {
        self.movieModel = movieModel
    }

    var id: String {
        self.movieModel.id ?? ""
    }
    
    var title: String {
        self.movieModel.title ?? ""
    }
    
    var rating: String {
        self.movieModel.rating ?? ""
    }
    
    var description: String {
        self.movieModel.description ?? "N/A"
    }
    
    var image: String {
        self.movieModel.image ?? ""
    }
    
    var year: String {
        String("\(self.movieModel.year ?? 9999)")
    }
    
    var genre: String {
        self.movieModel.genre?.joined(separator: ", ") ?? "N/A"
    }

    var rank: Int {
        self.movieModel.rank
    }
}
