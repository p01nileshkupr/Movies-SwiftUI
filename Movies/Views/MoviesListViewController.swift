//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Nilesh Prajapati on 2023/09/01.
//

import UIKit
import SwiftUI

class MoviesListViewController: UIViewController {
    
    //MARK: - Properties

    private lazy var host: UIHostingController = {
        return UIHostingController(rootView: MovieListView())
    }()
    
    //MARK: - View Lifecycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupHostView()
    }
}

//MARK: - Private Methods

extension MoviesListViewController {
    private func setupHostView() {
        addChild(host)
        view.addSubview(host.view)
        host.didMove(toParent: self)
        host.view.frame = view.frame
    }
}
