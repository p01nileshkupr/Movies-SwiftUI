//
//  MovieDetailsView.swift
//  Movies
//
//  Created by Nilesh Prajapati on 2023/09/01.
//

import SwiftUI
import Collections

struct MovieDetailsView: View {
    
    //MARK: - Properties
    
    var viewModel: MovieDetailsViewModel
    
    private var list: OrderedDictionary<String, String> {
        return ["MovieDetailsRankTitleText".localised(): "\(viewModel.rank)",  "MovieDetailsGenreTitleText".localised(): viewModel.genre]
    }
    
    //MARK: - Body
    
    var body: some View {
        List {
            //Header View
            MovieDetailsHeaderView(movie: viewModel.selectedMovie)
            
            //List view
            VStack(alignment: .leading, spacing: 10) {
                Text("MovieDetailsShortDescriptionTitleText".localised())
                    .fontWeight(.heavy)
                
                Text(viewModel.description)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
            }//: VSTACK
            
            VStack(alignment: .leading) {
                Text("MovieDetailsTitleText".localised())
                    .fontWeight(.heavy)
                
                HStack(alignment: .center) {
                    VStack(alignment: .trailing, spacing: 10) {
                        ForEach(list.elements, id: \.key) { item in
                            Text(item.key)
                                .font(.subheadline)
                        }
                    }//: VStack
                    .padding(.horizontal, 10)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(list.elements, id: \.key) { item in
                            Text(item.value)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }//: VStack
                    .padding(.horizontal, 10)

                }//: HStack
                .padding(.vertical, 10)
                .padding(.horizontal, 25)
            }//: VSTACK
        }
        .navigationTitle("MovieDetailsTitle".localised())
        .navigationBarTitleDisplayMode(.inline)
    }
}

//MARK: - Preview

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MovieViewModel(movieModel: moviesData.first!)
        MovieDetailsView(viewModel: MovieDetailsViewModel(selectedMovie: viewModel))
    }
}
