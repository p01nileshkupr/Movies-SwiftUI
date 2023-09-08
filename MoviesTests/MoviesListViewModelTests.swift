//
//  MoviesListViewModelTests.swift
//  MoviesTests
//
//  Created by Nilesh Prajapati on 2023/09/04.
//

import XCTest
@testable import Movies

final class MoviesListViewModelTests: XCTestCase {

    private var viewModel: MoviesListViewModel?
    private var mockService: MockMoviesListService?

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockService = nil
    }
    
    func testMoviesServiceSuccess() async {
        mockService = MockMoviesListService(mockData: moviesData)
        guard let mockService else {
            XCTFail("Couldn't create mock service")
            return
        }
        viewModel = MoviesListViewModel(service: mockService)

        await viewModel?.fetchMovies()
        
        XCTAssertEqual(viewModel?.serviceState, .succeed)
        XCTAssertNil(viewModel?.networkError)
        XCTAssertNotNil(viewModel?.searchResults)
        XCTAssertNotNil(viewModel?.searchResults?.map({$0.id}))
        XCTAssertEqual(viewModel?.searchResults?.count, 100)
        XCTAssertEqual(viewModel?.sortBy, .rank)
        XCTAssertNil(mockService.networkError)
        XCTAssertEqual(mockService.isEmptyResponse, false)
    }
    
    func testMoviesServiceWithEmptyResponse() async {
        mockService = MockMoviesListService()
        guard let mockService else {
            XCTFail("Couldn't create mock service")
            return
        }

        viewModel = MoviesListViewModel(service: mockService)

        await viewModel?.fetchMovies()
        
        XCTAssertEqual(viewModel?.serviceState, .succeed)
        XCTAssertNil(viewModel?.networkError)
        XCTAssertEqual(viewModel?.searchResults?.count, 0)
        XCTAssertEqual(viewModel?.sortBy, .rank)
        XCTAssertNil(mockService.networkError)
        XCTAssertTrue(mockService.isEmptyResponse)
    }
    
    func testMoviesServiceUrlFailure() async {
        mockService = MockMoviesListService(networkError: .urlfailure)
        guard let mockService else {
            XCTFail("Couldn't create mock service")
            return
        }

        viewModel = MoviesListViewModel(service: mockService)

        await viewModel?.fetchMovies()
        
        XCTAssertEqual(viewModel?.serviceState, .failed)
        XCTAssertEqual(viewModel?.networkError, .urlfailure)
        XCTAssertEqual(mockService.networkError, .urlfailure)
        XCTAssertTrue(mockService.isEmptyResponse)
    }
    
    func testMoviesServiceFailureForNoData() async {
        mockService = MockMoviesListService(networkError: .nodata)
        guard let mockService else {
            XCTFail("Couldn't create mock service")
            return
        }
        
        viewModel = MoviesListViewModel(service: mockService)

        await viewModel?.fetchMovies()
        
        XCTAssertEqual(viewModel?.serviceState, .failed)
        XCTAssertEqual(viewModel?.networkError, .nodata)
        XCTAssertEqual(mockService.networkError, .nodata)
        XCTAssertTrue(mockService.isEmptyResponse)
    }
    
    func testMoviesServiceFailureForNoResponse() async {
        mockService = MockMoviesListService(networkError: .noresponse)
        guard let mockService else {
            XCTFail("Couldn't create mock service")
            return
        }
        
        viewModel = MoviesListViewModel(service: mockService)

        await viewModel?.fetchMovies()
        
        XCTAssertEqual(viewModel?.serviceState, .failed)
        XCTAssertEqual(viewModel?.networkError, .noresponse)
        XCTAssertEqual(mockService.networkError, .noresponse)
        XCTAssertTrue(mockService.isEmptyResponse)
    }
    
    func testMoviesServiceFailureForRequestFailed() async {
        mockService = MockMoviesListService(networkError: .requestfailed)
        guard let mockService else {
            XCTFail("Couldn't create mock service")
            return
        }
        
        viewModel = MoviesListViewModel(service: mockService)

        await viewModel?.fetchMovies()
        
        XCTAssertEqual(viewModel?.serviceState, .failed)
        XCTAssertEqual(viewModel?.networkError, .requestfailed)
        XCTAssertEqual(mockService.networkError, .requestfailed)
        XCTAssertTrue(mockService.isEmptyResponse)
    }
    
    func testMoviesServiceFailureForParsingFailed() async {
        mockService = MockMoviesListService(networkError: .parsingfailed)
        guard let mockService else {
            XCTFail("Couldn't create mock service")
            return
        }
        
        viewModel = MoviesListViewModel(service: mockService)

        await viewModel?.fetchMovies()
        
        XCTAssertEqual(viewModel?.serviceState, .failed)
        XCTAssertEqual(viewModel?.networkError, .parsingfailed)
        XCTAssertEqual(mockService.networkError, .parsingfailed)
        XCTAssertTrue(mockService.isEmptyResponse)
    }
    
    func testSoryBy() {
        viewModel = MoviesListViewModel(service: MockMoviesListService())
        XCTAssertNotNil(viewModel?.sortBy)
        XCTAssertEqual(viewModel?.sortBy, .rank)
        
        viewModel?.setSort(by: .rating)
        XCTAssertEqual(viewModel?.sortBy, .rating)
        
        viewModel?.setSort(by: .title)
        XCTAssertEqual(viewModel?.sortBy, .title)
        
        viewModel?.setSort(by: .rank)
        XCTAssertEqual(viewModel?.sortBy, .rank)
    }
    
    func testSearchTextResults() async {
        mockService = MockMoviesListService(mockData: moviesData)
        guard let mockService else {
            XCTFail("Couldn't create mock service")
            return
        }
        viewModel = MoviesListViewModel(service: mockService)

        await viewModel?.fetchMovies()
        
        XCTAssertEqual(viewModel?.serviceState, .succeed)
        XCTAssertNil(viewModel?.networkError)
        XCTAssertNotNil(viewModel?.searchResults)
        XCTAssertEqual(viewModel?.searchResults?.count, 100)

        viewModel?.searchText = "Dark"
        
        XCTAssertEqual(viewModel?.searchResults?.count, 2)
    }
}
