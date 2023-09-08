//
//  MoviesListPreviewData.swift
//  Movies
//
//  Created by Nilesh Prajapati on 2023/09/01.
//

import Foundation

var moviesData: [MovieModel] { Bundle.main.decodedList("movies.json")! }
