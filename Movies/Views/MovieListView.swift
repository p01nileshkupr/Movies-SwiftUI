//
//  MovieListView.swift
//  Movies
//
//  Created by Nilesh Prajapati on 2023/09/01.
//

import SwiftUI

struct MovieListView: View {

    //MARK: - Properties

    @ObservedObject private var viewModel = MoviesListViewModel(service: MoviesListService())
    
    //MARK: - Methods

    private func sort(by option: SortBy) {
        self.viewModel.setSort(by: option)
    }

    //MARK: - Body

    var body: some View {
        NavigationView(content: {
            VStack {
                if viewModel.serviceState == .failed || viewModel.serviceState == .unknown {
                    Text(viewModel.networkError?.localizedDescription ?? "Service failure")
                } else if viewModel.serviceState == .succeed, let movies = viewModel.searchResults {
                    List {
                        ForEach(movies, id: \.id) { item in
                            //Destination details view for
                            let detailsView = MovieDetailsView(viewModel: MovieDetailsViewModel(selectedMovie: item))
                            //Row view for each movie record
                            let listRowView = MovieListRowView(viewModel: MoviesListRowViewModel(movie: item))
                            NavigationLink<MovieListRowView, MovieDetailsView>(destination: detailsView) {
                                listRowView
                            }//: NavigationLink
                        }//: LOOP
                    }//: LIST
                    .searchable(text: $viewModel.searchText, prompt: "Look for something")
                } else {
                    VStack {
                        Text("MoviesListActivityIndicatorTitle".localised())
                    }//:VStack
                    .frame(width: 150.0,
                           height: 150.0)
                    .background(Color.secondary.colorInvert())
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                }
            }
            .listStyle(.plain)
            .navigationTitle("MoviesListTitle".localised())
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        Task {
                            await viewModel.fetchMovies()
                        }
                    }) {
                        Text("Refresh".localised())
                    }
                    .disabled(viewModel.serviceState == .inprogress)
                }//:Refresh
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu("MoviesListMenuTitle".localised()) {
                        Button(action: {sort(by: .rank)}) {
                            Text("MoviesListMenu3Title".localised())
                            Image(systemName: viewModel.sortBy == .rank ? "circle.fill" : "circle")
                        }
                        Button(action: {sort(by: .title)}) {
                            Text("MoviesListMenu1Title".localised())
                            Image(systemName: viewModel.sortBy == .title ? "circle.fill" : "circle")
                        }
                        Button(action: { sort(by: .rating) }) {
                            Text("MoviesListMenu2Title".localised())
                            Image(systemName: viewModel.sortBy == .rating ? "circle.fill" : "circle")
                        }
                        Button(action: {}) {
                            Text("MoviesListMenuCancel".localised())
                        }
                    }//:Sort Menu
                    .disabled(viewModel.serviceState != .succeed)
                }//: ToolBarItem
            }
        })
        .onAppear {
            Task {
                await viewModel.fetchMovies()
            }
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
