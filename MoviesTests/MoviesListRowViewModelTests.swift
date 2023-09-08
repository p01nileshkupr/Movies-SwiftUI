//
//  MovieListRowViewModelTests.swift
//  MoviesTests
//
//  Created by Nilesh Prajapati on 2023/09/04.
//

import XCTest

final class MovieListRowViewModelTests: XCTestCase {

    private var viewModel: MoviesListRowViewModel?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = MoviesListRowViewModel(movie: MovieViewModel(movieModel: moviesData.first!))
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testMoviePropertiesAvailability() {
        XCTAssertNotNil(viewModel?.title)
        XCTAssertNotNil(viewModel?.image)
        XCTAssertNotNil(viewModel?.year)
        XCTAssertNotNil(viewModel?.rank)
        XCTAssertNotNil(viewModel?.rating)
    }
    
    func testMoviePropertiesNotEmpty() {
        XCTAssertEqual(viewModel?.title.isEmpty, false)
        XCTAssertEqual(viewModel?.image.isEmpty, false)
        XCTAssertEqual(viewModel?.year.isEmpty, false)
        XCTAssertEqual(viewModel?.rating.isEmpty, false)
    }
}
