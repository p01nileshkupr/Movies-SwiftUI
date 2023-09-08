//
//  MovieListRowView.swift
//  Movies
//
//  Created by Nilesh Prajapati on 2023/09/01.
//

import SwiftUI

struct MovieListRowView: View {
    
    //MARK: - Properties
    
    let viewModel: MoviesListRowViewModel
    
    //MARK: - Body
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: viewModel.image)) { phase in
                if let image = phase.image {
                    image // Displays the loaded image.
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    Color.red // Indicates an error.
                } else {
                    Color.secondary// Acts as a placeholder.
                }
            }
            .frame(width: 80, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(viewModel.title) (\(viewModel.year))")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.leading)
                
                Text("Rank: \(viewModel.rank)")
                    .font(.footnote)
                    .multilineTextAlignment(.leading)

                HStack(alignment: .center, spacing: 5) {
                    Image(systemName: "star.fill")
                        .font(.footnote)
                        .foregroundColor(.accentColor)
                    
                    Text("\(viewModel.rating)/10")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.blue)
                }//: HStack
            }
            .padding()
        }
    }
}

//MARK: - Preview

struct MovieListRowView_Previews: PreviewProvider {
    static var previews: some View {
        let movieModel = MovieViewModel(movieModel: moviesData.first!)
        let rowViewModel = MoviesListRowViewModel(movie: movieModel)
        MovieListRowView(viewModel: rowViewModel)
            .previewLayout(.fixed(width: 320, height: 150))
    }
}
