//
//  MovieDetailsViewModelTests.swift
//  MoviesTests
//
//  Created by Nilesh Prajapati on 2023/09/04.
//

import XCTest

final class MovieDetailsViewModelTests: XCTestCase {

    private var viewModel: MovieDetailsViewModel?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = MovieDetailsViewModel(selectedMovie: MovieViewModel(movieModel: moviesData.first!))
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testMoviePropertiesAvailability() {
        XCTAssertNotNil(viewModel?.title)
        XCTAssertNotNil(viewModel?.image)
        XCTAssertNotNil(viewModel?.description)
        XCTAssertNotNil(viewModel?.year)
        XCTAssertNotNil(viewModel?.genre)
        XCTAssertNotNil(viewModel?.rank)
    }
    
    func testMoviePropertiesNotEmpty() {
        XCTAssertEqual(viewModel?.title.isEmpty, false)
        XCTAssertEqual(viewModel?.image.isEmpty, false)
        XCTAssertEqual(viewModel?.description.isEmpty, false)
        XCTAssertEqual(viewModel?.year.isEmpty, false)
        XCTAssertEqual(viewModel?.genre.isEmpty, false)
        XCTAssertNotEqual(viewModel?.rank, 0)
    }
}
