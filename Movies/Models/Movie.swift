//
//  Movie.swift
//  Movies
//
//  Created by Nilesh Prajapati on 2023/09/01.
//

import Foundation

struct MovieModel: Decodable, Identifiable {
    let id: String?
    let rank: Int
    let title: String?
    let thumbnail: String?
    let rating: String?
    let year: Int?
    let image: String?
    let description: String?
    let genre: [String]?
}
