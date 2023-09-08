//
//  MovieDetailsHeaderView.swift
//  Movies
//
//  Created by Nilesh Prajapati on 2023/09/01.
//

import SwiftUI

struct MovieDetailsHeaderView: View {
    
    //MARK: - Properties
    
    var movie: MovieViewModel
    
    private var attributedRating: AttributedString {
        var result = AttributedString("\(movie.rating)/10.0")
        result.foregroundColor = .red
        result.font = .system(.title3, design: .default, weight: .semibold)
        return result
    }
    
    //MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                AsyncImage(url: URL(string: movie.image)) { phase in
                    if let image = phase.image {
                        image // Displays the loaded image.
                            .resizable()
                            .scaledToFill()
                    } else if phase.error != nil {
                        Color.red // Indicates an error.
                    } else {
                        Color.secondary
                    }
                }
                .frame(width: 80, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.leading, 10)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center, spacing: 5) {
                        Text("\(movie.title) (\(movie.year))")
                            .font(.headline)
                            .fontWeight(.heavy)
                    }//: HStack
                    
                    HStack(alignment: .center, spacing: 5) {
                        Image(systemName: "star.fill")
                            .font(.subheadline)
                            .foregroundColor(.accentColor)
                        
                        Text("\(movie.rating)/10")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.blue)
                    }//: HStack
                }//: VStack
                .padding()
            }//: HSTACK
        }
    }
}

//MARK: - Preview

struct MovieDetailsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let movie = MovieViewModel(movieModel: moviesData.first!)
        MovieDetailsHeaderView(movie: movie)
            .previewLayout(.fixed(width: 375, height: 185))
    }
}
